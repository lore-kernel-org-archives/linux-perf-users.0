Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB859651D
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890247; cv=pass; b=TdbNnhTPB72xm8sQl34AAXR0SzLFZ8zXSL2v8R/mjYvj8DYuP0nxENAQlsV2l2hQjZLodma434pFBBzA+S81OGhFomigVPYiiQY12RPbJ0TeGbY4XCzzVgITFJ/r5FgEHbRw1LYfkhGRbBWbtjAPfCY9Lx6NO4B/0mlpqsbkWbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890247; c=relaxed/simple;
	bh=IJsyfPGLpm8UMa/BqkR66GRSRbIqbVXIutmTDpcavo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIgK65fUfJ7AmD/i+4HGfMIQzkm4IbvQqRXhwN7OhzIHLZq7DwETxvnXShAiH83+SBG+xpt6bfzB6XcAHK3xMiNuDuH590EmGW6N4eLEabr3EXK4HmtsRT9cOT9/A7E18ZZ/5/btc20aS9e1fjQ6jsq7K17cs6dKLG0a7KOSHhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1JO8mhO; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1JO8mhO"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so638171cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788890244; cv=none;
        d=google.com; s=arc-20260327;
        b=oyu+ijAeMFwk7urv8wgxnbgRDea3hDFrpBfaeObwzurnxfjWTuhkf0ML2z2xCwV7L/
         vAPRntMGOmHWh0mk9ld4eEP1Cs9hVi0XzEfTosDb4phpvon1wPiB1iaoTkWle7C2mjUI
         dc640roEeev0cDlZMsPOlRaAWU2JxVrSLigq/HMtvJVmGswjwq6Rf6sGD5aICUPZ3v9g
         iIkJcV1U7cSo1aykuZuyDFtNNVsOgbYGB2WBF1Hyg3dq3pf9YOFa34MysyB5cH/TVMvM
         u/wJ5aVnwEQEyVNxUAyZR/49b25zGpXCk5d7GTP264KV0dSHUUUTF1f3RDh9H4oTZC+2
         bSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GB2pUu7GQQ4fx2+eTrSMAv2WzH1ekSifjwCfsPepe6g=;
        fh=P4Bw+EHnu70jcjnsvgXBqCpwuOZZu/M8tE00oKm2cAE=;
        b=tDQqYh4wW8wvrCTMmzrt5UTBEtz9a2mm1VFJ6+9Pe3UjBAEt8FlU65MYD/mGF6FszC
         ch2T6nSpEA7ENXZxWI1LL4N0dvQ2TKb1KqKVxTzV8lG/b5Oau1xhoueEVf00JYVMYadq
         dYdg1FIRchXP1sKkE6BjmNIRfcJf9zHdaNHFVGxqypMNMGi2qQjhim0JbVhP09GcRK9+
         rWOEs6VYJ0KovX1K2pXk500L0v1mIgLnMtAU62qGtmkIFJWoF90AJomA9l+iEDMgkd75
         hjiBeOsPA0yFNwzaivPLGCRXCZIlFO1C7993gVmrrKouQZq2zPMZZ779bSrwghBcA+Ox
         SOkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788890244; x=1789495044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GB2pUu7GQQ4fx2+eTrSMAv2WzH1ekSifjwCfsPepe6g=;
        b=r1JO8mhOpTrPt7K+I86Dk4yl8nd/GdYNc+Jw9WQoSbx9x+sbnn+kWzTrUFXGzDlyYu
         SXSqt/m8iMFPJLp1z+ncydsEF2diulLlIwtAhF9RaYXDf8SqP7LjSuoCEFUDl9dOZSOH
         a2u6h59F7cizQ4FrsyPyDMyzpSX+0vmXcxzw2E5kTSw1SRjW02wNAJ5VCDYc/IiWVg+f
         IBy5U2oQxje/7mab7o266M7p/Ett4YNmtpFsBPQLpfXlzJHZKorE6KJ5oSM48yl+OEvS
         5eJkUXT4zGUde6TQ+zQb5J6lZisMgDz2IiQ6uPS85R3RUcNIy29+thDiYEsIsliyRAl8
         IrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890244; x=1789495044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GB2pUu7GQQ4fx2+eTrSMAv2WzH1ekSifjwCfsPepe6g=;
        b=RjJzjPYmytLPp+CNnEHYy5e3h+/vUYvb3h4tlptBf5yb4Bp16uIT115KwGJII5uqG2
         Ajga3SWh+nyWRqnaY8DudlTeruDVEhl6qViZOKh4isxo5P3aDxp/hfTsC5fd+r0m48pC
         Lmrt1k1iE2wpifRoiGgx1iqZNhvwZow58hiUL4B5obybKkDEDllTbj4TG3viX0A7Rn3J
         zW6UQl95QL3IOs+iJck4jxC/ke+sji87IGz8rtw0ktVmYvIUwHsb20Bi+oLX1Iwq7sS0
         O4Q6KsbYncoW1YLDWTxPC8y+pCir4J+Pp6VkFWMd6bqsFlBIwKpOAQUJtKnPGPFlAWBI
         FbSA==
X-Forwarded-Encrypted: i=1; AKwUvBzlKN3vfbVHGAHKM3lrtA4W25j+40BDIfv6GPqs/5PVBquSQf6xV0Gg1BMRUr9tRHJYg9vlLbSwKf/ZEfT7d26D@vger.kernel.org
X-Gm-Message-State: AFuF++lyVDhAhe5tGTpiSFRUVqbwQBdSPjicsg6rtqI3IUf/TOFaz+XD
	J1XdGI+hi8lSzERE23m9xpXCiF7B41gABT3U9sGqW4UUMbvm+4EWZkryRu+o39XKH5sgoHFzBR6
	mutuIdMe0OuX63OstkC5oZA6Id6+e1AkawUhakjp4
X-Gm-Gg: AYBFou0KtTYdrPNYrOiW1br3BktD2DVK93MNOnLQtssLccWkZmLxcnriUOWJj8Chn29
	inlMdpFGWi4HIOxo+8VdoZWzCTH0MuvgMandcjaXEeFmV9fXKzOmZPuX+KducbJto1juHHgtpzg
	o1NmQEq+Xi0kVe87bFVbuUs+9lKHdecdQWsgjSM9Ojodgf9OqnM4CwY8LfIShg2KFekDdGZkHE1
	Xh4AUUwFqXhaRD57cEWiXRJSIXLjdpH3d0kOPuYoknUQPI4yJWZC3J3olevuCmb7YEKvkOxSrmr
	Nv8ZaOJHnDQxDJnN7dsxYgyitipBdW8JelQ04+ccCtWAVyl0QFsY0QtLPgjOqfVGzGGg6lJq3g=
	=
X-Received: by 2002:ac8:5d48:0:b0:530:4cc8:b0b8 with SMTP id
 d75a77b69052e-530a46fdc0dmr598661cf.0.1788890243316; Tue, 08 Sep 2026
 10:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788872630.git.wutengda@huaweicloud.com> <07d3cce3cb8561c07d7c77deac81eb9ab0540ccb.1788872630.git.wutengda@huaweicloud.com>
In-Reply-To: <07d3cce3cb8561c07d7c77deac81eb9ab0540ccb.1788872630.git.wutengda@huaweicloud.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:57:11 -0700
X-Gm-Features: AcwNN1VTgg87NRXDwKCaLCVHhILMhGw-jUsmsmeNaMp7Cz6AWjeluRRn2LoZeEU
Message-ID: <CAP-5=fWj19r_NcMS8DPeD7SQ7-Ak9_rRn=EOaBLUmxvPyHTSPg@mail.gmail.com>
Subject: Re: [PATCH v5 05/26] perf annotate: Normalize arch__dwarf_regnum()
 error return values
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org, xueshuai@linux.alibaba.com, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev, 
	Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Bill Wendling <morbo@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:05=E2=80=AFAM Tengda Wu <wutengda@huaweicloud.com>=
 wrote:
>
> arch__dwarf_regnum() returns inconsistent error values: early path
> returns -1 while the main lookup returns -ENOENT/-EINVAL from
> get_dwarf_regnum(). Callers only check for -1, so genuine failures
> can slip through.
>
> Normalize all failures to -1 to match the callers' expectation.

This sounds like a bug in the callers but this function is local to
annotate.c and is just a convenience so:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Suggested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index df70e95a8470..f3d17d153b67 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2492,7 +2492,7 @@ static int arch__dwarf_regnum(const struct arch *ar=
ch, const char *str)
>
>         reg =3D get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_=
flags);
>         free(regname);
> -       return reg;
> +       return reg < 0 ? -1 : reg;
>  }
>
>  /*
> --
> 2.34.1
>
