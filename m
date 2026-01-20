Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9433AD83
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932127; cv=pass; b=S4/QlSObso8s+jLz50n44bcleCBF4BpnvnDDU+Jk/feXP/45i44P43Evqn7eHmy+aQErc2417zIQMcduaVhkgNpW1XGayCEd65xoBg1ptMi+tc3pzkDHqD0dO2hVMt96FHMyLRnFHm6E+PkF8CYKcufBZlvNhx2WLufjpff1ZEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932127; c=relaxed/simple;
	bh=7SFTxV5bTd426Ox9ftT6wI+OInqjEd24MbX1HCiY+r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpmWxfx0NNuMOGGvV0+6MwzvuQsEmqwLKZavmQwhM1VAiPgnnp4PnDgEMYosGJvvfQDKBVq8qG23O1hZ2a7G8boY0x4hYItQ9/REm2XlzB0uyPm1BJxlORjCy30mabR2zJ0DiMiR75mMnHcSThpIqb+H3SDKaKN1DKbL79c179w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCTBiIoU; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCTBiIoU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a76b39587aso4525ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Jan 2026 10:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932124; cv=none;
        d=google.com; s=arc-20240605;
        b=T1g7/2nvEXbopDL49Z/mJmlbarlxgYAjPkSgTfSP4VaHoZMOYtjq9wUhMm1IvcKvOr
         7fQEd/RMS+VQHbe/blgCeHPkujgujSXgZRrQjV5O5YSozhCtrPNm8yybuHsUHGC0G4JH
         FZXR1M1AV/nXH86E0oPzu9SVqOmJtB6ll07fe/5Sw+pXGFFOPnR0KeYUigBJh+iisr1D
         IERwVOzn/vlL+tt9Tl61EwFCPCsSg+bssf+GnFSNh/gyzih4GBRFGop/0rQ0lvJniaH4
         zklv57vme2He7iF9o9KpGPNEAAFXtwcMiew+fG3npCRYStc4aaKO5bJ2odLLLmoV1Ia6
         NsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcDZOvP1V/LqXrs4TwTv85VHt6mfw5iCqYY5tfOtGIg=;
        fh=ePsVMcfpKSS45+1rD++ZY7bcUCRPGUlj2oAry5fEdDU=;
        b=R5sg2BpsEAyOBLqxwyoXEkI5iYsf8IJWx+epum0gipv4XoPugKzHyqzBuL4nW2pRhp
         Y2Y8xGINS6Uf7ssmt+f3Ds5wjb301a/gD5DNMeg3oFjiYLm+2TbMLGc2OSLM/ne0c4pO
         ePWZ2plkyOEGoql3nVbUWXz1Rrgam+lFouBjgRZuU5tqzTzR9yuACw6ueNMtShgolSgt
         ZDGFUAzJF57omojQboCJCSYCY194nxwTmoACqrovkjqMoGDS3Cmeh8Eys5ZuHYbxSOEQ
         K7m0yDiRcLyZyRZAmmZ+1tZ4MTAPJvpEmhKtKTOT57TKaI4U//1g0hlIfzWgy19nOQYb
         4ySQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932124; x=1769536924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcDZOvP1V/LqXrs4TwTv85VHt6mfw5iCqYY5tfOtGIg=;
        b=BCTBiIoUIRBPFAuEv1rsBqjE0wQ2/NIb4W7ZkoazjNxi6ZZDv9mCygLIVc6mMEWTmI
         m+T09zvZBGbSpMKQU+uwuw30N2B4dLpT96d6Jm4AqiQ4Xd4bI7/cGiP4rrl/GTrtGYii
         mhy458/UkaQFKZSka6TNJRUdlFsJef6kWD8VDRM26V04au+GPt/T8lX4I1W1ZNMIWScG
         LpK56bA9bxcSW7WMfGbaIYMkXoE7OV+T6ZnDH96/BFMDVJc0a2fLgjZeuimj7GLTgqVe
         BlnDFKi/hN8rrvhwUOXAqspT1Z5uTTMrmk2P9sBX+BxqdvlDzqY6Hmxyv4r+XLBawH+T
         8V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932124; x=1769536924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcDZOvP1V/LqXrs4TwTv85VHt6mfw5iCqYY5tfOtGIg=;
        b=sOTUjwCiIfSDXNaOTf8TRh4nUTyzLB5VS3tIl1G3UCZZrRCpqcrUfzg5GTXXpbaGMO
         +S3m5N+IudImlXsPcJSn5p5wHhGpiWxSeTaqdnI6AnL9Qi6grms2P9xPkUi5KHXDt9Ib
         3QpHDOTA1sCbh/kwNAUxX822ZKadWHQiG5TqOcB/Ne8c6ZDj+JcQviQevgr0UtbvEovC
         rri9/1JT+VNyNmppZPgFFlGeoYg1Auz1Bc3B1/2fQR9DmFkyEY9GqEv3m1yz1keGSnB5
         Ao0JEDBnDG3YI7dCRASybXClUbtmU3/ZnPGzXmDF2UhKHcyMSYouvPMiVh248U6tD1U3
         okhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9Ce9LoffJhpzS94z4TrSFcNoNUCmJ1HQvT+oIFoujW+i9WQKr0bl8xwk51RGtHwIY0jSgsWt0z4Xyc9fZOgN@vger.kernel.org
X-Gm-Message-State: AOJu0Yypin/0q7Bio1Jx2Jl0j9IrdoYoK4o91/JA837bDIRe/ibGCLdD
	G0d6D0yclIVeCITdqvaKr5AJ52+E5cBPxVdYJSRbhfCzWGHfA2F3TsnbsjTLq/Nd46SE49MBNuW
	f4eIwJ2dpixQ+xD0OdCyHBkqmKaDJ5uTrpPiUkyRX
X-Gm-Gg: AZuq6aKOYNyeouYjfm3KyDKzw8AJ4MGK/JOWCSsftlh8GUsF32lirErtqNsnjO0CnIG
	vHLyS+MVVxEKsg+bjlz2KsZ20K1qSA55XuI/a2vp8zLIxg4CYTy02PbDbdU9BTwUvfQTj3fultG
	ntDIU9R6b9U74K0uEOrgCp42xkmAhT3y2LqfYyOZxmzBWau7Y5LCidjbWoWj8xC85DAX36Mdgx7
	rXeFAN4cC3wbNklC1ScgHrKN/ZkIwwAUsZpjSc5NIikVMA9D4Jp12mo/cXlpfCJjsr84SgYziNr
	LrRRiPGi598rcNZ3Lj7PBf4mqA==
X-Received: by 2002:a17:902:f542:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2a72a7d4c76mr6004515ad.13.1768932123417; Tue, 20 Jan 2026
 10:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
In-Reply-To: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 20 Jan 2026 10:01:52 -0800
X-Gm-Features: AZwV_QhfLARa_naUlTDZtKKFoaCUggZJ95fRcdiBZca9HMcUuMebPHEEJPRruUg
Message-ID: <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Handle deleted JSONS in out of source builds
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:39=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The cp command here doesn't remove files that have been removed from the
> sourcetree. That means incremental builds can either succeed with stale
> events or will fail completely if a stale json file has a broken
> reference in it.
>
> Fix it by using rsync instead of cp. legacy-cache.json has to be
> excluded as this is a generated file isn't present in the source tree.
>
> This only happens when deleting a JSON file, which has only happened
> once since the linked commit. The fixes commit is marked as the origin
> of the problem in case any future changes that delete JSONs are back
> ported, rather than the first commit that deleted a JSON file.
>
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk=
/
> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files=
 to OUTPUT")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> This is a bit of a hack and I thought that making jevents.py handle
> multiple input folders would be a much better solution than this. Then
> we could have "gen-pmu-events" for only generated files and "pmu-events"
> for only in-tree input files. It would be very clear what's generated
> and what's not and all copying rules and special clean rules just
> disappear (and this isn't the first time these rules have caused build
> issues).
>
> Unfortunately, after a while of trying to modify the script I thought it
> was too invasive for now. The script does output per-file at the very
> bottom of the logic in process_one_file(), so adding files in another
> folder ends up re-emitting section headers when another chunk is output.
> Although other parts of the script do build things up in memory before
> outputting so it was possible to make those parts work with multiple
> folders transparently.

Thanks James!
Acked-by: Ian Rogers <irogers@google.com>
I see other rsync uses in:
tools/testing/selftests/sparc64/Makefile
tools/testing/selftests/bpf/Makefile
but they aren't the most compelling mainstream uses. I wonder whether
we can test for rsync's availability and if not fall back on cp?

Thanks,
Ian

> ---
>  tools/perf/pmu-events/Build | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index a46ab7b612df..079d04c4f7d8 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -12,13 +12,16 @@ METRIC_TEST_LOG     =3D  $(OUTPUT)pmu-events/metric_t=
est.log
>  TEST_EMPTY_PMU_EVENTS_C =3D $(OUTPUT)pmu-events/test-empty-pmu-events.c
>  EMPTY_PMU_EVENTS_TEST_LOG =3D $(OUTPUT)pmu-events/empty-pmu-events.log
>  LEGACY_CACHE_PY        =3D  pmu-events/make_legacy_cache.py
> -LEGACY_CACHE_JSON =3D $(OUTPUT)pmu-events/arch/common/common/legacy-cach=
e.json
> +LEGACY_CACHE_SYNC_PATH =3D arch/common/common/legacy-cache.json
> +LEGACY_CACHE_JSON =3D $(OUTPUT)pmu-events/$(LEGACY_CACHE_SYNC_PATH)
>
>  ifeq ($(JEVENTS_ARCH),)
>  JEVENTS_ARCH=3D$(SRCARCH)
>  endif
>  JEVENTS_MODEL ?=3D all
>
> +GEN_JSON =3D $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
> +
>  #
>  # Locate/process JSON files in pmu-events/arch/
>  # directory and create tables in pmu-events.c.
> @@ -31,17 +34,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>  else
>  # Copy checked-in json to OUTPUT for generation if it's an out of source=
 build
>  ifneq ($(OUTPUT),)
> -$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> +SYNC_PMU_EVENTS :=3D $(OUTPUT)pmu-events/.synced
> +$(SYNC_PMU_EVENTS): $(JSON)
>         $(call rule_mkdir)
> -       $(Q)$(call echo-cmd,gen)cp $< $@
> +       $(Q)$(call echo-cmd,gen)rsync -a --delete --exclude=3D$(LEGACY_CA=
CHE_SYNC_PATH) \
> +               --include=3D"*.json" --include=3D"*.csv" pmu-events/arch =
$(OUTPUT)pmu-events/
> +       $(Q)touch $@
> +
> +$(GEN_JSON): $(SYNC_PMU_EVENTS)
>  endif
>
>  $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
>
> -GEN_JSON =3D $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
> -
>  $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
>         $(call rule_mkdir)
>         $(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
>
> ---
> base-commit: 571d29baa07e83e637075239f379f91353c24ec9
> change-id: 20260120-james-perf-json-delete-fix-71553b379e8e
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
