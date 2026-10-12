Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E174E66C9
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842026; cv=pass; b=l8KMVaNhd2+rtQfNyATVDx3uxSqyxyARe/CN/JEWTIHKYZpKzru9mlOwq62I4kwh7kuwStRUaVYGMxwHaipssYclxNOGnpd26/RE5vNiV5SzB4pm7Fy1vI92U1NFtFRdZlt4bgike8aOBnTVBu9rjDBnN2PWKJSjc/nFVSynhVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842026; c=relaxed/simple;
	bh=GQkJdkA7OT/9hMa9O8Q4LEbNdFe7qTbtE31peqa29z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVqggJ431/f+oQuTDz2jjgpvkbTG0P0f1J6nnWa64TtFe9enxxXsmNkIwrEA6RwONvyDLYi7aDCdL7k1MnWaJOPYF35g6I3jD3OkTz7CXVOT5FCLY9CumAVEmGBdk7rQ7yeGnzgSaHVtTAncfeWH8YhIeA/9qFKfnjoZ0/E6Ikc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bp8HtfwG; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bp8HtfwG"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-533202fe429so544481cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 14:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791842024; cv=none;
        d=google.com; s=arc-20260327;
        b=GIQsyBgYlR6RYKzsR8AEZAlgykHJ1mgA63FdP4fMKry1fXtAYCfJjsInqmn0ZwT+JS
         RkQdLsOGnRZTnCKjdudzRjH5zMlm6iRTZeqfJSxcD/n5xmKiS4pLAoVQ4Vvgt8OiTPaB
         H9RG+RYFDWWJbfhVjhhwpPgMAcQForr52mOr7tUv9KBPpvhZhhvEVpC5oj7SOi+mhOB/
         lsyl28MfgS9iXue0VHpxFaIKPPwj1rFXpE3VJ9wqb2n6gjg+gEw1PTkvtsCuz+QsTowO
         PGo7WDGaA5AdJX09pYrEJyFSZXXGvUu7VQaFs+ojRDqFxxQIu3guTxb2BLeGEmjuyvNW
         9ByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pi/bWJhyirPFC8++uuaGsmPa6qZLaBSHWg7d4QXh3AA=;
        fh=rxjJPr5CGFvmkuXtDTFT7hKn5sJsEiBV0ZHkhRRZQIM=;
        b=WGBVmlsvYtcBk2OqyFFmRrynHZ8yehM+CTbbOd/q3k31JZouWJYQwhf1/ODVzpFofk
         FGd6KjXg3WiTvjVIMAHxF1hNByB9/Cxp6NOtHhokH+ZV+5MpSqSTnwUA07BaM5ownq0x
         hzV4goKL/XCoclCwnslN/NX0CayNBsOGHgUBQmSh4Ksjz5UzWQn2iVVF9GGsSODYdIrH
         g89Zw6KJRnWhD7fbPAuvXwV9ZsD+sCwvvBqZPnmgGRYIqh4G/X7IqEXghOb2haNxc8dr
         Rs1MuBK7fnPzuvYTSpkJXy9Nqa2UTgUi0yEslG5tCDZVsjG6Fcq1cld38M9fTe55awxq
         VGzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791842024; x=1792446824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pi/bWJhyirPFC8++uuaGsmPa6qZLaBSHWg7d4QXh3AA=;
        b=Bp8HtfwGhsettQ3nXPap24kDb0ebxoRC8YeLhn0+nNm9mu5R9t3CxBp1epooQm0Tqe
         VVZ1mQc094OtL0JC5tGz4Ve+79uHcom6VYlrlvmTsCVENlj6ZbgpIwRHQb0XjVxo939R
         S1AwV5HyOe1T27ch7SW346ftdgL8+xttpTxD7EUrVjQ8y7Hj4PmFLDCTEZGD/92lqqEV
         dkEsBCYwcqIhaw0mZQDWrhv7kGtarwpHHhiEmyK7dHXlcgNTn4zLiO539hy7JZU/PWog
         N9tmhHwuB0R/4p3kYb7d0iJaBK93VnKbbUA+Mq/Q9f5CqJlnNZulskQLvOS5e29myD5Z
         umYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842024; x=1792446824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pi/bWJhyirPFC8++uuaGsmPa6qZLaBSHWg7d4QXh3AA=;
        b=y5neBiX4QYZtngxo70QZWImDhVcPmul+SPIBTEPDMZ7fNILCPY33rUIB3CXoTQyMxg
         b9ioSNqblien9byk9MVV14eRZRU/RafCdn6cxW5xCYA945Oqlo8j86+IocqggTHTIjiB
         Tvb+fbIKYpQsJGSt/Q3tHV6ZWrnH70MEKJscC1Uv2wc0+AtKO4AvA3uc8FL8GkIo/0VD
         aQQvWhdA24WdY4PsEwHluxkPq5UPZizxhopGH1/yupNl+tCWEK6kOQCOsM4yCHPVIurg
         wnvk235MMbHtX+5WyaOt8NSUCAqRcNbEszgWqCtVG79yv4ov8+HQ/wBGzerJCUHb9xuD
         1sDQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/LBLGTsL9X4yUDDNmORgAgSF+MjgZuiz54utaRlVdf++LeFm35/yw3XxiYOPEK1ff1APpWwy71Jr7mjm4ZW+5@vger.kernel.org
X-Gm-Message-State: AFq9FYLZyq4NbJ6+6Df3dMObadnC8/aZq+K1SzJ7ka5JZrg0O/RiaML1
	qp/IrY1dQuvnjfiJid+XPwUPWUw0uGj1qumfuwCfZQqQRTyqpvWLi3pBq88kdJqQIWBJKZRE6+F
	m4EDULoyOjYHKJP9IHouqCkJ3qPf5DzeNO6nYlZ3a
X-Gm-Gg: AYBFou2AyI2oZGoV7keIht47QH2mw6iW0OAvqPBDisMkAIph6tMrFUMFfW4+c/skqWQ
	AgBI5oe1CElo1Zz5MMxjH7IRA/pCJ1R7zuoLYK+T8Is00uLognuLhaioLfSpcCa8D2c7eztTwrb
	vmwcPgpxzRnoOImTTQvbuqNaJVfBWc16eP5RLDSuoY/2MpARF/T+KHX7h1rfEkrr0X+Zw2Oambn
	zQQMPFI3i0lhrHLcf0jIW6TQdrTHFe1K90mgh+PKsFNYEinZXrxqzAMdA1MESuwKcexsxBoDxYz
	lu+Px8N3hvl0ancILHTMvS7Fm/I9H/KPode/FrFfADHxYRSf1a59PL6fp1TZRqDD1FKAO/50fjU
	KDbOGQRKh/N4=
X-Received: by 2002:ac8:5a91:0:b0:532:9003:35b1 with SMTP id
 d75a77b69052e-535b2e1f48emr39592221cf.2.1791842023805; Mon, 12 Oct 2026
 14:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012053013.14378-1-namhyung@kernel.org> <20261012053013.14378-2-namhyung@kernel.org>
In-Reply-To: <20261012053013.14378-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Oct 2026 14:53:32 -0700
X-Gm-Features: AclHuK-cu6LGqOlFADADJSW-JXKF7LFVV-5siK4pCPAahOQ4557KKmjokTmZfcY
Message-ID: <CAP-5=fVMwm_Rpi2OTVx74uGpU_dD7gSeqRVM_24=NkMUNYfjeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf symbol: Add missing symsrc__destroy() for libbfd
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 10:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When libbfd loaded symbols and there's a pending syms_ss, it'd be lost
> or overwrite existing symbols.  Let's destroy it before breaking the
> loop so that it can safely return from the function.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-162540@kernel.org
> Fixes: eac9a4342e5447cad ("perf symbols: Try reading the symbol table wit=
h libbfd")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/symbol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a394e742f9b18812..55a4b59195a08be5 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1932,7 +1932,7 @@ int dso__load(struct dso *dso, struct map *map)
>
>                 if (bfdrc > 0) {
>                         ret =3D 1;
> -                       break;
> +                       goto out_destroy;
>                 }
>
>                 if (!is_reg || sirc < 0)
> @@ -1997,6 +1997,7 @@ int dso__load(struct dso *dso, struct map *map)
>                         ret +=3D nr_plt;
>         }
>
> +out_destroy:
>         for (; ss_pos > 0; ss_pos--)
>                 symsrc__destroy(&ss_[ss_pos - 1]);
>  out_free:
> --
> 2.55.0
>
