Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558794;
	b=vB5aqgGBSpWFm0OqgBP5eySsZ3FILQbxQimi5PmcryOK4hPM5LcxDk6rq9A3PduHrd/T
	 B4yECgg2ipBB8f0V/o062qz3Xuo7St5AxC3ZXUsJVm2eYZb187VF2T8CoqQnS4I/1Wu1p
	 gYxRcNJDpdNmtztPIjISvqllGiJGoVeXg5Yk+a/NWS6M/XwU4HcN/j4m7h2NI7y9Dkter
	 atIhMDcJWFkwNGWI4GyQwtcQWf7nI8qVtmbAHJiHNxS+SJJSR9xR7rwlFxsA548k1Dsfp
	 qd01JPLR7b7D8GtGp5SdKTarGOjD6XPC5ndsOqcayGr6GDEGlxOwyvY8a2zVV7IVuKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558794;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OuD6OBaBTJ1t2xJWH9loHpgqWKlqR/94AiNdvwGR08w=;
	b=FDxBB9zCx0KBWYSFJJ0w5veL6Rc8aWCrrKCxiwbmxQ0A/xpPXKr8ALNXSiuShogSCeen
	 QHHwzQ6Z9hSAI1XyonI9MhImfhiHgn1UuZHWLKqHJcJschu5CygFn+MDgvkUOwJz/2412
	 ooimGSTiz9HHra5aiG0SoDO2rovSnrKx01bteKpshJ896ky60bAfsmy658vJwevaEObXq
	 1bsZWYRRtLU25K2vATPpUSFKkroveCBgyZ+Z5iW2/h5Zuth+nDdEiDrCDOjAXtrHlRQAV
	 8gIQEfuV8grj5QwpgWxWEzyicUjTgYK5Z++5CsQzlZ8iiTOv5rU3gzid/fOZWM4iROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lveSDGPS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B38606A327;
	Tue, 24 Nov 2026 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lveSDGPS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02EC1F000C4;
	Tue, 24 Nov 2026 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795558793;
	bh=OuD6OBaBTJ1t2xJWH9loHpgqWKlqR/94AiNdvwGR08w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lveSDGPSRM3DeognCZbQbDOZkKnasxdSVZpBEKjPfllQ2C8FEQYQ8DBVHtydJ4hQJ
	 1hP1fgN+J/QII6ELYRFQArvAHNt0mtsWAFRoimV7LC0fptJI5blBtmwJBMI48GuGqB
	 DgKtVL+f0S/jRTsJ8yKja62owY10an1OaiALxs9xpN1EUFV9cebTyaWeJgbwfLLURe
	 Rc+ytoiIXtLFhwvpa65mK9BnghpwVplKt4RuXlh+QbLm40tfG8N3zpvfJBHglpReqR
	 +LqQYGYNEYGFlu3AWgNffpYIOeH8akkTEoCsTPs+rJHi+QqFW32VGegLBRif9nbs/a
	 vgI5KRxd7rFJQ==
Date: Tue, 24 Nov 2026 14:19:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 03/19] perf annotate: Print the stats after the
 annotations
Message-ID: <awYNhyPWLG0g_nDn@google.com>
References: <20261123220024.14891-1-acme@kernel.org>
 <20261123220024.14891-4-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261123220024.14891-4-acme@kernel.org>

On Mon, Nov 23, 2026 at 07:00:08PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> With --code-with-type the instruction stats are printed from
> hists__find_annotations() before that event is annotated: the first
> event reports zeros and later events can report stale counts.  The data
> type total is only counted in --data-type mode, so --type-stat without
> it is incomplete too.

I prefer having type/insn stat before the result so that I can check the
quality easily.  But probably it makes sense to do it later when it's
used with --code-with-type.

Thanks,
Namhyung

> 
> Print the stats once after all events have been annotated, warning if
> --type-stat is used without --data-type.  Leave the TUI's alternate
> screen before printing, so the stats remain on the terminal.
> 
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debugging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debugging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  2 +-
>  tools/perf/builtin-annotate.c              | 20 +++++++++++++++-----
>  2 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 1a90b09a12d5abb1..d27eff28ba4f6af0 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -169,7 +169,7 @@ include::itrace.txt[]
>  	all data types it finds.
>  
>  --type-stat::
> -	Show stats for the data type annotation.
> +	Show stats for the data type annotation (with --data-type).
>  
>  --skip-empty::
>  	Do not display empty (or dummy) events.
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 7cb7e03d9a21d81b..b7f71cc95c0cd4c0 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -414,11 +414,6 @@ static void hists__find_annotations(struct hists *hists,
>  	struct rb_node *nd = rb_first_cached(&hists->entries), *next;
>  	int key = K_RIGHT;
>  
> -	if (ann->type_stat)
> -		print_annotate_data_stat(&ann_data_stat);
> -	if (ann->insn_stat)
> -		print_annotate_item_stat(&ann_insn_stat, "Instruction");
> -
>  	while (nd) {
>  		struct hist_entry *he = rb_entry(nd, struct hist_entry, rb_node);
>  		struct annotation *notes;
> @@ -663,6 +658,21 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  		hists__find_annotations(hists, pos, ann);
>  	}
>  
> +	if (use_browser == 1 && (ann->insn_stat || ann->type_stat)) {
> +		/* Leave the alternate screen before printing to the terminal. */
> +		ui__exit(false);
> +		use_browser = 0;
> +	}
> +
> +	/* Here use_browser is 0 in stdio and TUI mode, so pr_warning reaches the terminal */
> +	if (ann->type_stat && !ann->data_type)
> +		pr_warning("Warning: --type-stat needs --data-type\n");
> +
> +	if (ann->data_type && ann->type_stat)
> +		print_annotate_data_stat(&ann_data_stat);
> +	if (ann->insn_stat)
> +		print_annotate_item_stat(&ann_insn_stat, "Instruction");
> +
>  	if (use_browser == 2) {
>  		void (*show_annotations)(void);
>  
> -- 
> 2.56.0
> 
