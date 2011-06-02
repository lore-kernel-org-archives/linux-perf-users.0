From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] Add an unresolved symbol for deleted binaries
Date: Thu, 2 Jun 2011 16:20:18 -0300
Message-ID: <20110602192018.GA21739@ghostprotocols.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57370 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab1FBTU3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 2 Jun 2011 15:20:29 -0400
Received: by gyd10 with SMTP id 10so474017gyd.19
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jun 2011 12:20:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110511010305.GA4324@dev1756.snc6.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, May 10, 2011 at 06:03:05PM -0700, Arun Sharma escreveu:
> [ Not sure if this is the best way to do it. Suggestions welcome ]
> 
> All samples that couldn't be resolved are attributed to this
> synthetic symbol. This way, perf top correctly attributes the
> samples to the right dso, even though it could not resolve the
> address.

We can have multiple symtabs per dso: MAP__FUNCTION for code,
MAP__VARIABLE for data, so when using both types for a deleted dso we
would leak a variable so a test for dso->unresolved_symbol != NULL is
needed.

But I think here we want something else, make top deal with it,
basically using just one symbol object that it creates for such cases,
trying that approach now.

The first patch is fine (dso->deleted) and I applied it, thanks.

- Arnaldo
 
> Signed-off-by: Arun Sharma <asharma@fb.com>
> ---
>  tools/perf/util/map.c    |   50 +++++++++++++++++++++++++++++++++------------
>  tools/perf/util/symbol.c |    4 +-
>  tools/perf/util/symbol.h |    3 ++
>  3 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 042ba9f..b525cba 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -1,4 +1,5 @@
>  #include "symbol.h"
> +#include <elf.h>
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <limits.h>
> @@ -97,6 +98,26 @@ void map__fixup_end(struct map *self)
>  }
>  
>  #define DSO__DELETED "(deleted)"
> +static int check_deleted(struct map *self, const char *name,
> +			 symbol_filter_t filter)
> +{
> +	const size_t len = strlen(name);
> +	const size_t real_len = len - sizeof(DSO__DELETED);
> +
> +	if (len > sizeof(DSO__DELETED) &&
> +	    strcmp(name + real_len + 1, DSO__DELETED) == 0) {
> +		pr_warning("%.*s was updated, restart the long "
> +			   "running apps that use it!\n",
> +			   (int)real_len, name);
> +
> +		self->dso->unresolved_sym = symbol__new(1, 4, STB_GLOBAL,
> +							"<unresolved>");
> +		if (filter)
> +			filter(self, self->dso->unresolved_sym);
> +		return 1;
> +	}
> +	return 0;
> +}
>  
>  int map__load(struct map *self, symbol_filter_t filter)
>  {
> @@ -116,27 +137,21 @@ int map__load(struct map *self, symbol_filter_t filter)
>  					  sbuild_id);
>  			pr_warning("%s with build id %s not found",
>  				   name, sbuild_id);
> -		} else
> +		} else {
>  			pr_warning("Failed to open %s", name);
> +			self->dso->deleted = check_deleted(self, name, filter);
> +			return 0;
> +		}
>  
>  		pr_warning(", continuing without symbols\n");
>  		return -1;
>  	} else if (nr == 0) {
> -		const size_t len = strlen(name);
> -		const size_t real_len = len - sizeof(DSO__DELETED);
> -
> -		if (len > sizeof(DSO__DELETED) &&
> -		    strcmp(name + real_len + 1, DSO__DELETED) == 0) {
> -			pr_warning("%.*s was updated, restart the long "
> -				   "running apps that use it!\n",
> -				   (int)real_len, name);
> -		} else {
> +		self->dso->deleted = check_deleted(self, name, filter);
> +		if (!self->dso->deleted) {
>  			pr_warning("no symbols found in %s, maybe install "
>  				   "a debug package?\n", name);
>  		}
> -
> -		self->dso->deleted = 1;
> -		return -1;
> +		return 0;
>  	}
>  	/*
>  	 * Only applies to the kernel, as its symtabs aren't relative like the
> @@ -151,10 +166,17 @@ int map__load(struct map *self, symbol_filter_t filter)
>  struct symbol *map__find_symbol(struct map *self, u64 addr,
>  				symbol_filter_t filter)
>  {
> +	struct symbol *ret;
> +
>  	if (map__load(self, filter) < 0)
>  		return NULL;
>  
> -	return dso__find_symbol(self->dso, self->type, addr);
> +	ret = dso__find_symbol(self->dso, self->type, addr);
> +
> +	if (ret == NULL && self->dso->deleted)
> +		return self->dso->unresolved_sym;
> +
> +	return ret;
>  }
>  
>  struct symbol *map__find_symbol_by_name(struct map *self, const char *name,
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dbd1944..a22b6b0 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -137,8 +137,8 @@ static void map_groups__fixup_end(struct map_groups *self)
>  		__map_groups__fixup_end(self, i);
>  }
>  
> -static struct symbol *symbol__new(u64 start, u64 len, u8 binding,
> -				  const char *name)
> +struct symbol *symbol__new(u64 start, u64 len, u8 binding,
> +			  const char *name)
>  {
>  	size_t namelen = strlen(name) + 1;
>  	struct symbol *self = calloc(1, (symbol_conf.priv_size +
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 943a054..d8a31a4 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -149,6 +149,7 @@ struct dso {
>  	u8		 build_id[BUILD_ID_SIZE];
>  	const char	 *short_name;
>  	char	 	 *long_name;
> +	struct symbol	 *unresolved_sym;
>  	u16		 long_name_len;
>  	u16		 short_name_len;
>  	char		 name[0];
> @@ -235,6 +236,8 @@ void machines__destroy_guest_kernel_maps(struct rb_root *self);
>  int symbol__init(void);
>  void symbol__exit(void);
>  bool symbol_type__is_a(char symbol_type, enum map_type map_type);
> +struct symbol *symbol__new(u64 start, u64 len, u8 binding,
> +			   const char *name);
>  
>  size_t machine__fprintf_vmlinux_path(struct machine *self, FILE *fp);
>  
> -- 
> 1.7.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
