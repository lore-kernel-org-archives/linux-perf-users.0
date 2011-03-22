From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [PATCH] Symbolize stripped binaries without buildid
Date: Tue, 22 Mar 2011 18:22:47 -0300
Message-ID: <20110322212247.GA3594@ghostprotocols.net>
References: <20110128221133.GA25958@radium.snc4.facebook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51355 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab1CVVWx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Mar 2011 17:22:53 -0400
Received: by ywj3 with SMTP id 3so3074952ywj.19
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2011 14:22:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110128221133.GA25958@radium.snc4.facebook.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Dave Martin <dave.martin@linaro.org>, linux-perf-users@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Em Fri, Jan 28, 2011 at 02:11:33PM -0800, Arun Sharma escreveu:
> Symbolize binaries which don't have buildids and are stripped, but have a .dynsym.
> 
> Signed-off-by: Arun Sharma <asharma@fb.com>

Sorry for taking soooo long to look at this, as I mentioned some time
ago I wasn't on the CC list, so it fell thru the cracks.

Srikar just mentioned that to me and by coincidence I was working on
fixing bugs on cross analysis, collecting perf.data files on a ppc64
system to run report on my workstation, a x86_64 machine.o

But if we do as in your patch we will miss looking for the .dynsym on
the build id cache (DSO__ORIG_BUILD_ID_CACHE):

[acme@emilia ~]$ cat want_symtab.c 
#include <stdio.h>

int main(void)
{
	int origin, want_symtab;

	for (origin = 0, want_symtab = 1; origin < 5; ++origin) {
		printf("origin=%d, want_symtab=%d\n", origin,
want_symtab);
		if (origin == 4 && want_symtab) {
			want_symtab = 0;
			origin = 0;
			continue;
		}
	}
}
[acme@emilia ~]$ ./want_symtab 
origin=0, want_symtab=1
origin=1, want_symtab=1
origin=2, want_symtab=1
origin=3, want_symtab=1
origin=4, want_symtab=1
origin=1, want_symtab=0
origin=2, want_symtab=0
origin=3, want_symtab=0
origin=4, want_symtab=0
[acme@emilia ~]$

So I'm applying another patch I came up with that I'm attaching to this
message.

Please let me know if you guys are ok with it and if I can add a
Tested-by: you.

- Arnaldo

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 15ccfba..a84db85 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1480,7 +1480,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
>  	 * Failing that, do a second pass where we accept .dynsym also
>  	 */
>  	for (self->origin = DSO__ORIG_BUILD_ID_CACHE, want_symtab = 1;
> -	     self->origin != DSO__ORIG_NOT_FOUND;
> +	     self->origin != DSO__ORIG_END;
>  	     self->origin++) {
>  		switch (self->origin) {
>  		case DSO__ORIG_BUILD_ID_CACHE:
> @@ -1530,6 +1530,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
>  				 self->long_name);
>  			break;
>  
> +		case DSO__ORIG_NOT_FOUND:
>  		default:
>  			/*
>  			 * If we wanted a full symtab but no image had one,
> @@ -1538,8 +1539,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
>  			if (want_symtab) {
>  				want_symtab = 0;
>  				self->origin = DSO__ORIG_BUILD_ID_CACHE;
> -			} else
> -				continue;
> +			}
>  		}
>  
>  		/* Name is now the name of the next image to try */
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 670cd1c..6b79ab9 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -201,6 +201,7 @@ enum dso_origin {
>  	DSO__ORIG_GUEST_KMODULE,
>  	DSO__ORIG_KMODULE,
>  	DSO__ORIG_NOT_FOUND,
> +	DSO__ORIG_END,
>  };

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="want_dynsym.patch"

commit e988a8fbd20e5562399f802c69276aa42938e229
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Mar 22 15:42:14 2011 -0300

    perf symbols: Look at .dymsym again if .symtab not found
    
    The original intent of the code was to repeat the search with
    want_symtab = 0. But as the code stands now, we never hit the "default"
    case of the switch statement. Which means we never repeat the search.
    
    Reported-by: Arun Sharma <asharma@fb.com>
    Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    Cc: Dave Martin <dave.martin@linaro.org>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Ingo Molnar <mingo@elte.hu>
    Cc: Mike Galbraith <efault@gmx.de>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Tom Zanussi <tzanussi@gmail.com>
    LKML-Reference: <new-submission>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 651dbfe..17df793 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1486,7 +1486,9 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 	 * On the first pass, only load images if they have a full symtab.
 	 * Failing that, do a second pass where we accept .dynsym also
 	 */
-	for (self->symtab_type = SYMTAB__BUILD_ID_CACHE, want_symtab = 1;
+	want_symtab = 1;
+restart:
+	for (self->symtab_type = SYMTAB__BUILD_ID_CACHE;
 	     self->symtab_type != SYMTAB__NOT_FOUND;
 	     self->symtab_type++) {
 		switch (self->symtab_type) {
@@ -1536,17 +1538,7 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 			snprintf(name, size, "%s%s", symbol_conf.symfs,
 				 self->long_name);
 			break;
-
-		default:
-			/*
-			 * If we wanted a full symtab but no image had one,
-			 * relax our requirements and repeat the search.
-			 */
-			if (want_symtab) {
-				want_symtab = 0;
-				self->symtab_type = SYMTAB__BUILD_ID_CACHE;
-			} else
-				continue;
+		default:;
 		}
 
 		/* Name is now the name of the next image to try */
@@ -1573,6 +1565,15 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 		}
 	}
 
+	/*
+	 * If we wanted a full symtab but no image had one,
+	 * relax our requirements and repeat the search.
+	 */
+	if (ret <= 0 && want_symtab) {
+		want_symtab = 0;
+		goto restart;
+	}
+
 	free(name);
 	if (ret < 0 && strstr(self->name, " (deleted)") != NULL)
 		return 0;

--82I3+IH0IqGh5yIs--
