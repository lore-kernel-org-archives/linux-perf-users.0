Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709D372B3C;
	Fri, 15 May 2026 19:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875134; cv=none; b=sb4mcN66yDLciUDXiqIeZ08d4++R5sNLPmgd8EEBCht2oFw7AfBMY++F60Yd7/eYIrOsGjvU/8n5cdmfTBDFMQDdvwmoIJ8xoWSsDDY3nXFjB1izMzU2h/4rRC0T71DOqpddq6QX6uLmjjr7rIR9LH62vmYGaC0zWbaL/enbifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875134; c=relaxed/simple;
	bh=hgBExgRuttMoDCcNN3qBnatYtIBMjKrnIPoUSRzHU2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WLEmHe+Myy+l3FRuwpKoTrtNJ6DCrO7fYvaPRv235+pTfzgZIK+VPIiZBywp3mjCvDwpf+T/V3o1lOSHf24roGr6vsyJkz6jN/mDvVYL+m/sIM8VFi75OOuRJiZ4w9vJH/eVZ54jTQjz6zlYGZfGGOveU3Bf77cokKFMRZE1+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ryo5xw+d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ryo5xw+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3C0C2BCB0;
	Fri, 15 May 2026 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875134;
	bh=hgBExgRuttMoDCcNN3qBnatYtIBMjKrnIPoUSRzHU2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ryo5xw+d7O8oVoj4u5/T08aEX/4jeaS9tjuzmFfpv2aLFMg0nOTxj/2927tG9Hw+t
	 9GpAmasrRAbomLZSnckQAAZsneNDf3Nkn7dVieCNJCQQRsKmWK6M2zUhFC3lsvU2xx
	 3cmld4PvKAH+R+h2/c1AxmOJ43PCnwf6m8lcJH8h3rt7TPqHy723ntfZ26g3h6gsh5
	 p10PEnqU+fExycSjl2iSJAOZ6JwCBTH1FtFrCfdPg4t9MrBUgpcZAEdURw1BXdPj8+
	 y8cQLdzvVx///5MCKLnDNfRkqaHWxWi8isXNlCtizDk4YdE772myg6LwH2Gn7ht0+U
	 mgSJG63o5WkBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage
 into standalone compilation unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260515193314.1593560-11-irogers@google.com>
References: <20260515193314.1593560-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 19:58:53 +0000
Message-Id: <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incremental build breakage and partial clean failure due to Make=
file dependency chaining and Python file closing order.
--

commit 6c014984ddc9092cbb7ef975a3904baefa427ed5
Author: Ian Rogers <irogers@google.com>

perf pmu-events: Split big_c_string storage into standalone compilation unit

This commit splits the large big_c_string literal into a dedicated
pmu-events-string.c file to allow parallel compilation during Kbuild.
It updates jevents.py to output both files and adjusts the Makefile
dependencies to ensure jevents.py is only executed once.

> In jevents.py, defer closing output_string_file until
> the absolute tail of main() to guarantee identical modification timestamps
> with output_file, preventing redundant rebuilds during incremental runs.

Is this guarantee accurate? Since output_file is never explicitly closed
in main(), it gets flushed and closed automatically during Python
interpreter shutdown, strictly after main() returns.

Will this result in pmu-events.c having a slightly newer modification
timestamp than pmu-events-string.c on filesystems with nanosecond
resolution?

> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build

[ ... ]

> @@ -224,6 +234,10 @@ endif
>  # and inputs are dependencies.
>  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) $(OUT_DIR) $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVEN=
TS_MODEL) \
> +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> +
> +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> +	@:

If pmu-events.c consistently ends up newer than pmu-events-string.c
due to the Python teardown order, won't Make permanently see
pmu-events-string.c as out-of-date?

Could this silently trigger redundant recompilations of pmu-events-string.o
and relinking of perf on every incremental build?

Additionally, if pmu-events-string.c is deleted while pmu-events.c
remains up-to-date, Make will execute this dummy recipe and then attempt
to compile a missing file. Does this pattern handle partial cleanups
gracefully without creating a build regression?

> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py

[ ... ]

> @@ -1476,6 +1488,8 @@ struct pmu_table_entry {
>    print_mapping_table(archs)
>    print_system_mapping_table()
>    print_metricgroups()
> +  if _args.output_string_file:
> +    _args.output_string_file.close()
> =20
>  if __name__ =3D=3D '__main__':
>    main()

Should _args.output_file.close() be added here alongside
output_string_file.close() to ensure their final filesystem writes happen
simultaneously before interpreter shutdown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515193314.1593=
560-1-irogers@google.com?part=3D10
