From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 02/11] perf tools script: Support insn output for
 normal samples
Date: Mon, 4 Mar 2019 15:48:32 +0100
Message-ID: <20190304144832.GI30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-3-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-3-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:41AM -0800, Andi Kleen wrote:

SNIP

> @@ -1234,9 +1243,12 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  {
>  	int printed = 0;
>  
> +	if (sample->insn_len == 0 && native_arch)
> +		arch_fetch_insn(sample, thread, machine);
> +
>  	if (PRINT_FIELD(INSNLEN))
>  		printed += fprintf(fp, " ilen: %d", sample->insn_len);
> -	if (PRINT_FIELD(INSN)) {
> +	if (PRINT_FIELD(INSN) && sample->insn_len) {
>  		int i;
>  
>  		printed += fprintf(fp, " insn:");
> @@ -3277,6 +3289,7 @@ int cmd_script(int argc, const char **argv)
>  		.set = false,
>  		.default_no_sample = true,
>  	};
> +	struct utsname uts;
>  	char *script_path = NULL;
>  	const char **__argv;
>  	int i, j, err = 0;
> @@ -3615,6 +3628,12 @@ int cmd_script(int argc, const char **argv)
>  	if (symbol__init(&session->header.env) < 0)
>  		goto out_delete;
>  
> +	uname(&uts);
> +	if (!strcmp(uts.machine, session->header.env.arch) ||
> +		(!strcmp(uts.machine, "x86_64") &&
> +		 !strcmp(session->header.env.arch, "i386")))

why is this check and native_arch bool necessary?
i386 data will be overed by arch/x86

jirka
