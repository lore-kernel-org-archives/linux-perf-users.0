From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v5] Allow user probes on versioned symbols.
Date: Thu, 13 Apr 2017 11:20:20 +0900
Message-ID: <20170413112020.8c98e0a082ad821a43d968c3@kernel.org>
References: <967814e0-0d5a-4970-38d8-04d7dae9d5b1@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755943AbdDMCUg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Apr 2017 22:20:36 -0400
In-Reply-To: <967814e0-0d5a-4970-38d8-04d7dae9d5b1@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: pc@us.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi Paul,

On Wed, 12 Apr 2017 09:41:51 -0500
Paul Clarke <pc@us.ibm.com> wrote:

> @@ -396,8 +407,26 @@ static void symbols__sort_by_name(struct rb_root *symbols,
>   	}
>   }
>   
> +int symbol__match_symbol_name(const char *name, const char *str,
> +	enum symbols_tag_includes includes)
> +{
> +	const char *versioning;
> +
> +	if (includes == SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY &&
> +	    (versioning = strstr(name,"@@"))) {
> +
> +		unsigned int len = strlen(str);
> +		if (len < versioning - name)
> +			len = versioning - name;
> +
> +		return arch__compare_symbol_names_n(name, str, len);
> +	} else
> +		return arch__compare_symbol_names(name, str);
> +}
> +
>   static struct symbol *symbols__find_by_name(struct rb_root *symbols,
> -					    const char *name)
> +					    const char *name,
> +					    unsigned int includes)

Here, you might miss replacing this 'unsigned int' with enum.
(actually, enum is equal to int, not unsigned int)

[SNIP]
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 5245d2f..67b017e 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -348,8 +348,19 @@ void arch__sym_update(struct symbol *s, GElf_Sym *sym);
>   #define SYMBOL_A 0
>   #define SYMBOL_B 1
>   
> +int arch__compare_symbol_names(const char *namea, const char *nameb);
> +int arch__compare_symbol_names_n(const char *namea, const char *nameb,
> +				 unsigned int n);
>   int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
>   
> +enum symbols_tag_includes {
> +	SYMBOLS_TAG__INCLUDE_NONE,
> +	SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY
> +};

BTW, would we need such 's' for plural and third person singular for type name?
And also, you should use enum type name for prefix so that other developers
easily find the definition of enumeration, e.g.

enum symbol_tag_include {
	SYMBOL_TAG_INCLUDE__NONE = 0,
	SYMBOL_TAG_INCLUDE__DEFAULT_ONLY
};

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
