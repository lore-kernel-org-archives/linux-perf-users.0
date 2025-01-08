Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE31CDFD5;
	Wed,  8 Jan 2025 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736367293; cv=none; b=QNNVt7gAx0nnXJ3WLbjpiw1d+Km2zZz1I6DpZfvjzV7ABKBJyaD0Fz/nq96tGWKglnqJDAz44+cEBnTu9NLVrnXn1ksg1cYSIbImmzViraHZtjpbQZizYuuwKWIHcMsL5ArDMO/nSXQ64PtxDH0Q49AJ6m1FtVgseVGgYBL/gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736367293; c=relaxed/simple;
	bh=+k8VSgg2WNZLayqdbQDDh8INehLekajaO7o4aXfvkpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWImct6xtt/W4KrfVX8mGvdYlQNphEolVqh6zOa9YEg+HtKoogq9GXrw4XdmJ5Q32o6Erfbf+zmYMDYi2IwRBkBSaIn8yogxnqaQu/rak/YB09NnJMwz6FP6HVz0DF65UOHYT6GVD9LJjnVTH+VvIGSzwGlil8GAnx53LYW+MJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el/bqvOE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el/bqvOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEA1C4CED3;
	Wed,  8 Jan 2025 20:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736367293;
	bh=+k8VSgg2WNZLayqdbQDDh8INehLekajaO7o4aXfvkpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=el/bqvOEmDTzHp5fiNlPZyX8I/jbI79LrxZhOyFlRE2mlN2YQJPBX8XoFMH8+/zhz
	 QOxms9We+e8b6bF0okRur4OeFWM60a1IZraBU5+v6Hrdt/fnSSPnWLucPXLeE///HU
	 wH3zvmmHhIeMSXlTIEjLz4r5AWMFKS1You4/PdNpxnBpf946W3JUIp19drATxrpyiP
	 2SSGRy32UJYi4zcfGz6QrGh54TsXYIknlpZYooz7Sk9GWn9Y2SnavOKuSpusWVphuE
	 28/1a+ITi0dKmQmKW9fuCRnGnJ56k1jjGEdgF8AQmHWooUdrah2a1XzlAiL7Eh6STU
	 zNseIIk+8fhvw==
Date: Wed, 8 Jan 2025 17:14:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf machine: Don't ignore _etext when not a text symbol
Message-ID: <Z37cuobj6NVRUKoo@x1>
References: <b3ee1994d95257cb7f2de037c5030ba7d1bed404.1736327613.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ee1994d95257cb7f2de037c5030ba7d1bed404.1736327613.git.christophe.leroy@csgroup.eu>

On Wed, Jan 08, 2025 at 10:15:24AM +0100, Christophe Leroy wrote:
> Depending on how vmlinux.lds is written, _etext might be the very
> first data symbol instead of the very last text symbol.
> 
> Don't require it to be a text symbol, accept any symbol type.

I'm adding a Link:

Link: https://lore.kernel.org/all/752a31b0-4370-4f52-b7cc-45f0078c1d6c@csgroup.eu

To give more context as where this has been observed, and also add a
snippet of your explanation there, this:

----
# grep -e _stext -e _etext -e _edata /proc/kallsyms
c0000000 T _stext
c08b8000 D _etext

So there is no _edata and _etext is not text

$ ppc-linux-objdump -x vmlinux | grep -e _stext -e _etext -e _edata
c0000000 g       .head.text	00000000 _stext
c08b8000 g       .rodata	00000000 _etext
c1378000 g       .sbss	00000000 _edata
----

Thanks,

- Arnaldo

> Fixes: ed9adb2035b5 ("perf machine: Read also the end of the kernel")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 27d5345d2b30..9be2f4479f52 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1003,7 +1003,7 @@ static int machine__get_running_kernel_start(struct machine *machine,
>  
>  	err = kallsyms__get_symbol_start(filename, "_edata", &addr);
>  	if (err)
> -		err = kallsyms__get_function_start(filename, "_etext", &addr);
> +		err = kallsyms__get_symbol_start(filename, "_etext", &addr);
>  	if (!err)
>  		*end = addr;
>  
> -- 
> 2.47.0
