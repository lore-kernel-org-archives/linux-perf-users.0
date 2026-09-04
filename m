Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116721CD2C;
	Fri,  4 Sep 2026 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556679; cv=none; b=gtuDEvkN3fIEMy23pxwlipEDj9V4F7pzn8jeiOJABQkjzjSIMHjGeEBkrxgmdBfnRBkGcIhXa+zERC/2tZed6FpCUAu+C0KIB4u/7cgeLExSFETcSNzAobeloF+KkFJ+KO43AcNelq3nexyhUUxyiLOKyzSFtGZhc0V/C1Fx/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556679; c=relaxed/simple;
	bh=vSdMM/5gpnDT7T8x46xxXgkVXn801UrRB1DfeEKnwwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hv2E8qDNRXhpU1Iq3Dbnhy/zrHYGhK6Jifm0tskVeG8KKduIp++iOC4VUYFuVYDmZZEq9iWa6iMquIxq4ygjiiugkBrhXOU/N8Pqm0vFwfVbyNQ0jDSF35Fk+/mEIbREmZ7TrtJmCZV4GvcokHKQoC1sJxMDj6QG2Bx8qJzgeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm0U/QCT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm0U/QCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245461F00A3D;
	Fri,  4 Sep 2026 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788556677;
	bh=0L3yJWBuGxxyn+2aUUPOzcCWgLt4R0SmyiyBXOHBamc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bm0U/QCT/ijumLpbh5woHAXMEtHhaZyaxFV/5VfbxPceKCp4Br6y/Jtj7rZZRvESd
	 bXJZ/ziiObPdDs/HxtxgeeSQSbcqvha5Edd2Kxum7clIZJAMXJ57ZTE3AAGt0TtCJy
	 ohr3plWHRC+u30/ULbf4PMLEfP3rix8VeRFUaiMFrdA+5qeytxtw7HjYSyvdrSL4uo
	 ssLDl5M4tJe/yZKFuQVD34ERZTsDsfXSXGKqv/DXKzmFQ+il5mqfEc50scZhP2mG/0
	 MtpmGOIwOzSeHv4pwanL2wX7F+Ghp81nNCH00EKqqL11AOMq3hxSJ/fIS5F8cd952p
	 ++o3eIDXXl9/g==
Date: Fri, 4 Sep 2026 18:17:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, howardchu95@gmail.com, neelx@suse.com,
	chjohnst@mail.com, sean@ashe.io, steve@abita.co,
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v6 1/5] perf trace: Fix error checking in
 btf_struct_scnprintf()
Message-ID: <aps1gjTwaMbDNQWa@x2>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-2-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133122.751733-2-atomlin@atomlin.com>

On Mon, Aug 24, 2026 at 09:31:18AM -0400, Aaron Tomlin wrote:
> btf_dump__dump_type_data() returns the positive number of bytes dumped on
> success, or a negative error code (e.g., -EINVAL) on failure.
> 
> Currently, btf_struct_scnprintf() checks if btf_dump__dump_type_data()
> returns 0. When a negative error code is returned on failure, this check
> evaluates to false, causing the function to proceed down the success path
> and advance arg->augmented.args past the unprinted struct data before
> returning 0.
> 
> Consequently, when syscall__scnprintf_args() falls back to the default
> argument beautifier upon receiving 0 from trace__btf_scnprintf(), the
> fallback beautifier or subsequent arguments read from an erroneously
> advanced augmented arguments buffer.
> 
> Fix this by checking for '<= 0' ensuring that on any failure or 0-byte
> dump, 0 is returned without modifying the augmented arguments pointer.
> 
> Fixes: cb32035214b9 ("perf trace: Pretty print augmented struct args using BTF")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c3c7f1f85c53..1bc39f674f11 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1066,7 +1066,9 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
>  		return 0;
>  
>  	/* pretty print the struct data here */
> -	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> +	if (btf_dump__dump_type_data(btf_dump, type_id,
> +				     arg->augmented.args->value,
> +				     type->size, &dump_data_opts) <= 0)
>  		return 0;

Applied the series, only change I made was:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c530196..4c8f91f0f854b382 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1066,7 +1066,7 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
                return 0;

        /* pretty print the struct data here */
-       if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
+       if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) <= 0)
                return 0;

        consumed = sizeof(*augmented_arg) + augmented_arg->size;
(END)
acme@number:~/git/pahole$

As this source code allows for longer lines, having it like above helps
in reviewing, we can see straight away what the change was. There was a
clash a few patches later that expected that reflow to be in place, I
adjusted that as well, no code changes in both cases.

Please avoid reflowing things.

Thanks for your work, appreciated!

- Arnaldo
