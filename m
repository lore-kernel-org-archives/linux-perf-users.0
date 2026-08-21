Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037436B907
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295378; cv=pass; b=NFeGgEJgOuoxn2eUAFXC4HTF7a1GxbuA+X/v7NDQg+r21jJs4Vvg2eSkKOR7cECpvdXmU+jhUcqOfUgZpL8lk5AX0gQ6DQFYhQR8fRnuTCjxDTOgXS7pUXs37IppLCnDmgNc36XPB+iF9S99HHf/IOGKSeAUm+oRn2iUTLUrRsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295378; c=relaxed/simple;
	bh=pRugMMf7cQy/AulUJSOF0mbQ0113EGSXQNaclE2tc9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6hIJwvL1zSGwtPeNiLb6NU9k71mfJ4dcbJBHDRFPDHlTRXbyFk95VizzLbVMCTU5wXP5iREQWCAK4QdsJ8ssXgBVzZtXY/qldgB3BXv3QyIlHdNyF2b1On3dpg1dP558in7hhq0mICp9nwf0Owdf2SKUztXqk9MOn0KRzOCbyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b=NbgDlZdS; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20251104.gappssmtp.com header.i=@hev-cc.20251104.gappssmtp.com header.b="NbgDlZdS"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so1379321a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 23:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787295375; cv=none;
        d=google.com; s=arc-20260327;
        b=JU7y1MbJO+opNNTlctI25QtJLylxB2qFMscpvFI2o2Yy+xyY+jzblO7SR1QVmIRVyg
         yyb33jwDOOl1uEEo6sRwSv9MiP8+VBoMlWCTU7DuBPtnu87CNQNcNJ0BfszCaobPGQgy
         O+/+ZM+qZ3rBM45cWJZJaRlMgB9PnNDKxbculaFIBqZsL6z8WBKHya1o9RAjW86wmlu1
         mZQFHXRt+M37q/OE3EC9O6wsqiBMKMpujsmgEu7PsAfk1arB279jw85m6EExvUFhrMRg
         s19vP/mUfQ5rzh5Pit8nypSmRxKfUs0zHgFDLSv8Ud/qJttaxZdYjFXv70cFbWR++dCY
         z0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4btvZlASkisNw9ocQY2OC/xtC3q2O98fHaxaVu3itu0=;
        fh=wlQbY2jremfkekN6poYN4WaxAi3Ptfy8yUuIafj9J6g=;
        b=tCHkpHM5IRNhSYSXsw/fTzhuDY8ZDB/NnyujlP6atKxVIK7z1FmdsbafBQpER1oSjM
         5XFyfgHX7x7BBGw8yf4SEhLTNJQvgsVNSMIUvf5PyLU2xnw632dOFopaLAX3T0DJnIeH
         YGCFPv4ewSt/j4jW+AgMzxdNPGnzQ7rmj6ocKKs8gPSceYAJCIb3FJy7j/fYR/Y2l9O6
         ZkleXJOHabhRj4fFJCKOeoNlMsI3tF4ORxBlIA78i6JFHJt8zsca9LiQUFUabW6hXY6E
         jBjewA8ivqTnTbszSKiJRSxnqRUwJI7iJUW9OQKpr0DdSypgMltOFokUyfBtsGZT79Fp
         7poQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20251104.gappssmtp.com; s=20251104; t=1787295375; x=1787900175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4btvZlASkisNw9ocQY2OC/xtC3q2O98fHaxaVu3itu0=;
        b=NbgDlZdSqz5GcGYu4naWwpznysYJmor1B4un5eLoSvyYyvJR7tflCdgbhxGy84SMRx
         t29UopNtKXQBpZ3IATqV7FfozStG2YWq5DBBzMyQi0/eEiEjjjm8ZjALsB9QE4H1fjGd
         JWvhlbt1S/p7BdQM63Hno508vr4ZE5bW3ejEUF3wxbh9rADwOHoL5S0ZfBnMmvXTp0D2
         W5yGcwH2XsvMERAUJQS+wPg1IqqlShLQiabriQeimetuCEYzNXUYd2WScn28lkVKl4AP
         WfWc+l50PaaP0ERfpnT73ipfaOt8YF5H7kEbD8mDXG0Pblm38LhUe4bSfeyTkSB6QZv4
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787295375; x=1787900175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4btvZlASkisNw9ocQY2OC/xtC3q2O98fHaxaVu3itu0=;
        b=kbIIRd/ZZBEJlkQ4Kw4EFhC9gj/7hGFY8c3MnwQLuNNDu9uCRILBNC1BbSrYfcqZc0
         y2T7X4ANGhRBXWYqF45TAmKMaeGguIa13tjh1tndMSpKskJoWmJUegrbGpqvfuAHyvkQ
         Z2GBMnPSM1JSNLHqcDuVQNCAbTP8kqE1+61N7KAxkWuW2eNvZQuAz4Q3Te0BJKC1h7r5
         kvXI82xipS6VoWYJj3sMogY0LlHRM5KbEc3Xa0zg1XC4ZVfT5b0HzxHe4RNvorEdP8ZH
         bUTJPbH9fVS5zoiBSVhVQEgM0ymrxekLEzxejskYRnJMitRid8CEFH7q+nH4qVmrwuhs
         Qu/A==
X-Forwarded-Encrypted: i=1; AHgh+Roz7Ehz/suSKUCgLmYa0BpaICbhuIm5t8L9vmVX1NZpy0U6DLTUjR+1gItpXXXm43E9/WhEhQ4V3s8MrgG/Bwvf@vger.kernel.org
X-Gm-Message-State: AFuF++lHAC0rwwOdr5ln554BC16TuF0Yc04dLLQFwiEiiPhK1oAFNa3l
	+u4TJBIBUUOLMg6Rm2kSzje2b0h9WMBIcwKQGHZPib+ULOBgv0+XSvxURj6JSm1uc2lHzeXjWZ1
	JMgPMzBS0jPRAmGJEd3YfO7a3NYWdcWpO63/SIqUi/A==
X-Gm-Gg: AR+sD13rB+Uf5bvcLrrReJx0GQ4f5zKxltWrR573KLnYucAHBvDqveyMbPYShSqaERH
	8OSMrz6bwMw21BXLQaGZPuHb38J8Ue+liSM25i2o0kstZQvUz0jJVdfOsZHXCJBSj2crkOzL+xl
	1Lf6p4+0JjLHp3LduHeRNoE71agiDu3s/qjcJ8Ead+lXxSCnlWsMFLT1TGTTrjres+7ho9cxax5
	pm69LxO1nifAFrb+e7GkUq2Q3Qgg4GA4buLzudG8GW0ZuNkcnHBGeyYt8GHSVOEnhj4DAtJ5fXI
	SCa1H9wXPGBD1zoGJ86+ZeeOU0eMdL4bcXJ7IJPQCsRDAQ1tWy08jPItdEDwE+52gxix3Nm8IWr
	z
X-Received: by 2002:a17:907:7252:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c246a683ff5mr385761466b.14.1787295374985; Thu, 20 Aug 2026
 23:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821032702.4258-1-lifangxu22@gmail.com>
In-Reply-To: <20260821032702.4258-1-lifangxu22@gmail.com>
From: WANG Rui <r@hev.cc>
Date: Fri, 21 Aug 2026 14:56:03 +0800
X-Gm-Features: AcwNN1VAsMWBGHA5vFvhzEYs5evQH83OB2bLAaaWqwneLfx2z5VO9rkTvf6PYig
Message-ID: <CAHirt9gpik6SuGSri9yaOhBbuitDeyXrekpQ5=vbN2u-_aSKfg@mail.gmail.com>
Subject: Re: [PATCH] perf build: Add rust target flag for loongarch cross compile
To: Li Fangxu <lifangxu22@gmail.com>
Cc: acme@kernel.org, namhyung@kernel.org, chenhuacai@loongson.cn, 
	peterz@infradead.org, mingo@redhat.com, git@xen0n.name, 
	linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, lifangxu <lifangxu@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 21, 2026 at 11:29=E2=80=AFAM Li Fangxu <lifangxu22@gmail.com> w=
rote:
>
> From: lifangxu <lifangxu@kylinos.cn>
>
> Based on commit 30f998c992c9 ("tools build: Fix rust cross
> compilation"), add rust target flags for loongarch cross tool to fix
> perf compilation error:
> *** Unknown rust cross compilation architecture loongarch. Stop.
>
> Signed-off-by: lifangxu <lifangxu@kylinos.cn>
> ---
>  tools/perf/Makefile.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ba307e78fe1..42c0ef213750 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1149,6 +1149,8 @@ ifndef NO_RUST
>      RUST_TARGET_FLAGS_s390     :=3D s390x-unknown-linux-gnu
>      RUST_TARGET_FLAGS_x86      :=3D x86_64-unknown-linux-gnu
>      RUST_TARGET_FLAGS_x86_64   :=3D x86_64-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_loongarch :=3D loongarch64-unknown-linux-gnu

This duplicates the earlier patch, which was already Acked:

https://lore.kernel.org/loongarch/20260414080500.320095-1-r@hev.cc/

Best,
Rui

> +
>
>      ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
>        $(error Unknown rust cross compilation architecture $(ARCH))
> --
> 2.43.0
>
>
