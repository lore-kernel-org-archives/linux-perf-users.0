Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057F33C1BD
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713811; cv=pass; b=Qe77KAoye3nW2vsXCvbPHMRPU74iqsN1KUwUDEXI2FBQRgtzbRV21q1HATGlQFH1FTdm1Zn6eDs69PKwyOSm6AJbrGX+jn2+ouFNDPKN0GhCqCq3qtLzOpiezO6RNop0Mo0oHEl279NAIv5qQw/0ZXnLqVfnSVR9kMbwcxU4vsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713811; c=relaxed/simple;
	bh=aXBxYbeVhZxo6I3+OIVlYQrgePmLDGWZfPjy2dNKowg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CajyOXq65loKhOh+k0DLRV2HnKF3XV0t4MewAaH1H2eel+zPjgUUkPr3R0pfKAE3dl/N80xhKreuyapVGTaRNx+6AtdouJABug02Fv3Off3AxOSMqptb+bWN7YBBuxQAIsHzF7O6EMOZbMIwBKEI/EAYx0Hm2ysRWKweAETPzmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwoHZKFN; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwoHZKFN"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124b07e5fe4so377431c88.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 00:56:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770713808; cv=none;
        d=google.com; s=arc-20240605;
        b=DYwn1vwQO/VNdTOnlhGgUuKy0I6Nufv/8EoXjCI98BPHXFe4/8ZC9AV+AZhOzk95b6
         vPLROdBg8CH3+GOuVYK/f/Sfk9yvBtBDAc0ETNsV6u1SX1Lz2SKQ+WOl8Yr8M647wTVq
         BaqlpFs+twKJ5Pj1Lb3VAw7E+90t2azRoi1RWKn2zvf4bSUqnosDuYUxsFS3LeFEirPr
         DdVq5+6yesKXKej4F+MzYH0zppu6N026fiXzIuKp7hOMUSkr+ROurPP7p0A13yuCSKu7
         zjmoKhBCVtcijrCXektiLpBYDjcFIvseCeDnGGjUAQIF+dFqQ+eN9ntTjewqJtnOJL3l
         fgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o0TbjqkXCG8vCO0P97Z3XLOfGaNWuyWnyzx2yegPCmA=;
        fh=4pw8676IR0ZE7xxUUYqSkuA/RlmGNztOcQ2xvBBPqfg=;
        b=NBhmbiSriAWhEuF2ePxc8wSE9Kna0I92gmG78yKgRDOgry7y0EIMkNjx6MHYoYXfXh
         oAqhsv5mnOWC/jf/KdfAR+jQmjLRni0Ahzh7upn1OXf6tHBY4t7QQcOap2kYi72F3nKo
         hlWlnWCg2iRgtGVz5XVYZgbBFL0GbIqybcPeM4JYEOZ0LQV1snTMXNjsirVe4oXymgg7
         il6d+87T9NX/3zvI0o7YtqfBT9WUZh9RZ8GbRWqcEmSa7dSU31fRMWfkPyT9/NwOvrpV
         6RFGKfSIdhoOVwUW2CAM+RqwHsYncgab3ttMIl3oLkoFJciYRQChy2cZtUwGbQm6wPII
         Vl2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770713808; x=1771318608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0TbjqkXCG8vCO0P97Z3XLOfGaNWuyWnyzx2yegPCmA=;
        b=bwoHZKFN4OtaX56U5SnDa2uG5nngOkA+ncUaq9AmIusMKkTkuwv9+xnveE7z9j+pj0
         TK1GSoSWTagKv1lLorYDKdGiHffj+YrO4uqSxYla6rYohMFpaSRV6a0zKB/7Kns2efBT
         yV61bsBK/KWkgrYonb5NdZcQM6qYY1tnsTa+6aHqKPn2xB8SPMRl/Rl8SHHfoDj5+Aeo
         rDZjsojNpI0b6sDT+dJT2pJI2YH7zwKlLXYEFxnw9OqHzfw2skYerUXSZoNdYhxXdlSq
         LFJegnObhq6aIAYKQGrt3WKgCp2kxCqY8M4h+5TBWIon/RfT4JtKCmoTc0DdF+g78rg1
         CfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770713808; x=1771318608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0TbjqkXCG8vCO0P97Z3XLOfGaNWuyWnyzx2yegPCmA=;
        b=vWkz1pv4UhBo7hoX6ZusrYTuE9212FP/rQvVIkPKw5TcAJxCs88yH+KfvV3hNwXYWI
         +W5nEV5N0Ts/BztnGEEKDcIRYHwvk0k/6k6Mt6gdjO3Vyt/4VNkXRje5OdliMmn0q1dt
         Xl95n75Jgyzg6UzulmdcEo1PWtGsjuO0WejZ/rMCbP68hKXZjCjpofB6d8f2US3MblIT
         DV2kO/cSEumdSynDiIL1GY+hu/y99NRFVNcIZ+mQalfGORPv58QYV4/u+XOPaY13BwbF
         wZnR3Fx8tp9XTFVgGsicsjbTSprxCJd5ogsuaRt7XPNWxoXvar7ion+ILJXCh73O+/bq
         +0xA==
X-Gm-Message-State: AOJu0Yxr0NTQSVfsvusLfc2VnP6/pIVqdl3h3ZmkSsZ9WPj/tB1LPhs6
	AVu8qcvWxyZGxFQmCQYeEg+yWnjXNKH5G437CfqUm7Ss+mZ1dzDFXTHIzjxZu0xJbzsPLlqSHOK
	xmA0aKIFhWozuSN2wUMhnMeQ7fXnfJsxgL+KJSLE=
X-Gm-Gg: AZuq6aKuQWmAR4gScUgZoA2hO/ThLHhPidhKjOI6mdNAAuVimEBDY4KqqFboNv9ps3n
	Jh920g1+OXnqHSE6qcU24K8bX+oF4fanRd0MkZc69CKnkAtfP2FhIMvo5Rvtuo5saQseKUPxK0F
	gdJOo/zS5LaOprh9wlnoLkBVkBMVNv0IKYWTnos+koeJ8H+p3qmg51pkXWF1cSyN17TyGzNweKm
	K596cQrGxgzEGMRgxRrj9xYOuaqp6NkoOFg2Dc/3Q+H9B2fWbPZO/t7fpy9v/ZQETGZbu0rs5vQ
	BbMXz8eOhxJveeJJ8VxtUiN2hbvSYm6XTNlIQB2E3V2x3vHw77BgYWbrWfGpP0hNEO+9Xh5mpYz
	qBbXDSFFyHMTNVHP50qzgeeKF
X-Received: by 2002:a05:7301:d17:b0:2b7:121a:99f with SMTP id
 5a478bee46e88-2ba8caf671fmr212585eec.0.1770713808366; Tue, 10 Feb 2026
 00:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209140533.194251-1-9erthalion6@gmail.com>
In-Reply-To: <20260209140533.194251-1-9erthalion6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Feb 2026 09:56:36 +0100
X-Gm-Features: AZwV_QhoQIBrlXQb9p-Te6elgDG-x3oBl25Rk3Aj45Sd7rj9jbMPlIwZYS--B8Q
Message-ID: <CANiq72mW=hcvUGt=WENRiYVeVbb2bnYzizE00Eo-MW3b_MwRrg@mail.gmail.com>
Subject: Re: [PATCH v1] perf tests workload: Formatting for code_with_type.rs
To: Dmitrii Dolgov <9erthalion6@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Brown <broonie@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 3:05=E2=80=AFPM Dmitrii Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> One part of the rust code for code_with_type workload wasn't properly
> formatted. Pass it through rustfmt to fix that.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602091357.oyRv6hgQ-lkp@i=
ntel.com/
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Could this please be applied (or fixed in-place)?

It is now in next-20260209, and we check this in different CIs. It
also makes LKP give spurious reports, e.g.:

  https://lore.kernel.org/all/202602100751.ldfRitCJ-lkp@intel.com/

Thanks!

Fixes: 2e05bb52a12d ("perf test workload: Add code_with_type test workload"=
)

Cc'ing Mark since I think the plan is to check in linux-next.

Cheers,
Miguel
