Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342C42AFA2
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577061; cv=pass; b=Pc/qts8+KlaEurcPkIV0WbE1gmaJHb/E1+TDjKcKSpKuVxR2t52U6GwlHdsyGyPrN7F0TvSPDumUz7hCHP71olA1p8zZh17uREKTm6dqxtQhlSbhm5BKwUqWSM5uUipzXz4ag43BdFZamLuQOGgfWwT8zLLD5HN8AWwhpQDrxg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577061; c=relaxed/simple;
	bh=kVMuxP528UVhx8CScODWh+GxODAT8gMpn349lBnk4+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5CIQY9B2kb1sczEVBxGZUAv8iNOVMYkB3CtYcisX60BX6zrlolG2wkkpeVON69L9kDl5dUXrYtmpnVjuh++OSCEkrmcmgmAMyc/7ZgeQUBsfgBuo9hcE470tJ8oK40IR1ApHb0lwUkHxAciA5ypaxftFKiSPB1WOWZ7kcGcGXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REzFepgL; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REzFepgL"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10ed63c0so46901cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786577058; cv=none;
        d=google.com; s=arc-20260327;
        b=roqP1yUboXg8drkOFsaenR/tS6RjKB9Ug03HOVGMw2S5OPQL8y94hYihCMxrM4nGUs
         rxoFmQhmX2KOT7v0awM+1DO8YedUu1kurRybOPVBc0CajhOX7pUzZIGJMDUe2xu5G/h0
         a/kVrW2M8aqQGa3q5ovKzNHASVoZCS/BKuihNqMx02jIENArvcQWDmtcsxE24xTI9RyJ
         nhc5a0QAH5AOc0lyuzoOqzWL8ye9bmxMxnasTzv5UZ27v03HhWKfID+DubxElZFwIRGQ
         Co85TAk2P6Qfl17PZoi3/AU+p9n3CLqmga48rCMqdNtr0ReyJs4xlfUqEgjv6iwfpWvA
         0BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ikGTdtrVSy8Ppvpv2+qlgO613IF25tnGTmR5lP5vLAs=;
        fh=4U3SGnfdBkV5ZA+0rACrdkkLqPm8VrSR2UAwX/arwwg=;
        b=kT2Ca3vMr1oHbhlKmgJ6/tIGnzImvFpeFQDeMhoZ+Wmp+fYSB0/jDylH9pMmiz250m
         QLqFNbbPf4cxD21x/yguwIiEok9k97icwUf4b9LmHrLZ2xf2BXV8pi1H9ZdZeSOJo7NF
         n1nlRD+f24CMSdcoqHcqnZL0l/UUDuelkRPIq9DWvDppTgKPkq848WA4p//OHy1IXBRv
         zRhk7zZr1RsLLJSoo3EXuXTkDQ36WnMG63HfMAchG4AWo2yIE4FNtA2OYLfUyDkxhcsW
         zwhDnBVkHZ2c0SxSlzAw2o3J/d//noQBBepRhpwPBeG5pn2rlCnqyxKZiJ++5BcA0XHs
         hThg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577058; x=1787181858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ikGTdtrVSy8Ppvpv2+qlgO613IF25tnGTmR5lP5vLAs=;
        b=REzFepgLAEvdpAtPCoPh1HfOviTidPfqA6oRdstvXmngZbxn7ipSicKKQ+GaB6Grtb
         nI22ERLHVgxMOcFYYanzyVTC006fLmNdF3y2M2RcDaxP5f/JO+digBxLUwnhDkuP7CD9
         qMbZLRjCubXGMYYNkq0+1HZjxPUYd5JcZgQ+UogGJnv+1TTRYhYMTTnRpjJbWoKZzW0W
         t7gzxD9OEt3nT6t7DpF8D1Xq7w9PoM38UNhuBLGaUJvqZjHJVGKzF5RFg2+GvUi6xAZK
         vH3yejuztaAyiq0oHsV+6xULkcF6DgdtEDI+BlKQJ83Au2WViHF4/RRLAsLxivRpxsS9
         0zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577058; x=1787181858;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikGTdtrVSy8Ppvpv2+qlgO613IF25tnGTmR5lP5vLAs=;
        b=LW6oEJWhke99/xST9FlPmolXS2oe8OOoS1YA5NgQqOsJFSlqjdCTUA0g9x76D7lTvG
         Z9l1wgwKrbgP3Tm3Lteu19evlcjuu0AkpNkD0gCzDGprpUYaGNa/6BPrr6RopGoJMgbw
         qMf50b04vJq252WoWJ3EpW0H+cNl9fJbxuV0WxpyCx3wyAEMoBSyhdCoUOjZzIv/TNCh
         y9gKCaBMf6qBiA/65nu05sEl7yLH/YDFmJWwu6/zMObMcCch9HuEX/+HNOUz1eYdkqeA
         IcIP93ugSAu8PPPJypJoA6W2zVPRBDbBsF9qcD9ORdDFPX6QjDoTCeCXYJsAYHfayDmK
         o/RA==
X-Forwarded-Encrypted: i=1; AHgh+RrQq+NcP6LkdzffDCBd8IHkTrk1OWCGUJoMxckcfxblzxtFg3kJ1SXpY9nkoudwxgV3iIfsJ8yGpomE/hyq4oD6@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmQazP52ao+lc7kPpHl3PvnJeAWuA8MVlUI5GWbBZzV/g5MsL
	nR/czztHljKhUdVQ49ajBnKkOj+LgvEXc5T5ehyCQhFdICpLWK9HnTrxWl/002dxzBhJWWxI+Cx
	R38r3dkaJ+GLplImCfiAA+RKaVLrqQHShBZukIcWA/LHpiMLRPnxDYK9G
X-Gm-Gg: AR+sD13Uir82jQjlmjO+pb9+36In+SJQotsVon9hFTFQAZbplUM3W+ltqF7x583veFI
	jc1E2KP/rBBJsiBbhlxIA5/oTy2Nx5e2W7evYuUXSOIqKNo7RKt81hU4dxujbs1VKECg318z9Lf
	vj6GM5D+tS83IzJFH6NGTlc/HizwXeAhZI4egAHIeXaQ4Od/7Cqx4gXS7zhAOhY1DcWcd8vKtNM
	E4OVy/3zJfXO0sdDWyIoJT//IkxMoAeaUzRGeqyro3CXJpYShevxRoOixEfRJ0GVu9H007Le2Nw
	ZqNlVKtYr3ccIeNVXzop9gzDXaQQqOKU3YC6F0uKix+++wyTQTE=
X-Received: by 2002:ac8:5894:0:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52d76909f7dmr2143601cf.8.1786577058004; Wed, 12 Aug 2026
 16:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811175140.7235-1-acme@kernel.org> <anyq-lNV-J6q5t1a@x1>
In-Reply-To: <anyq-lNV-J6q5t1a@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Aug 2026 16:24:04 -0700
X-Gm-Features: AUfX_mzReoITYGdzEPYun8G8ehGzaaYqsRPvs_2Jzg0YIIisx5UqQKt3PZ0KZqw
Message-ID: <CAP-5=fVSO-y7y0c5ux89STcN6jXeUtrrbf7fQCwYWq8hSKbr0w@mail.gmail.com>
Subject: Re: [PATCHES v3 0/5] perf DSO hardening series
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Aug 11, 2026 at 02:51:29PM -0300, Arnaldo Carvalho de Melo wrote:
> >       Please consider merging,
> >
> > Five hardening fixes for the perf DSO data handling code path, all foun=
d
> > by the sashiko-bot AI reviewer:
>
> This is sashiko clean now, if there are no further human reviews can we
> have this merged?
>
> https://sashiko.dev/#/patchset/20260811175140.7235-1-acme%40kernel.org

2 nits about adding asserts as well as comments.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Best regards,
>
> - Arnaldo
