Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91321D7E21
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Dec 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262175; cv=none; b=LhjqZIxLNVdExT9tOh+yGFtzCsZpjhjYPZ/akVHJxrbj88+kJw0dKhFXX86jc9rOTjR2DOrF+K7qb+fzfEFcCiyKYLBXNPdpOiw6pGJ5R61Uj6mLiKvPf/HshmjhWalSo8vD9kJZJrcjchiSDQgpqm27gaBXeRPUFlf5Je3YiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262175; c=relaxed/simple;
	bh=lKdLWe/SZJmvSJbGODIVCNl2JSHPMUmkfZB1nxXo1q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/3dQMkJjRM6hk87S7Oa+0+IK3/pckF+hHu9TFVy9v1wURwi4BAT0T7oIBoCRF9zECOOAKfgW744Mk0KL3jMQ4F5tszuytllPVn/8P1dN0UYsDRGeC0y7LwmGm2cNgpOEgW2iaLJ6XELWmPoF0pKi7G7Xt3x0PcrdBDk5DmoWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215666ea06aso1997325ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Dec 2024 13:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262172; x=1733866972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glJaBF5CBV53P8K9dMF3I9/DuJYRSXOyq3KekLTNSp4=;
        b=ZHPqJUQGIM95u6KuKZ6bkV2uRMaHpGuDkAzXdLYMEWsi/1QTm7EXgfpIROoBpXQHh8
         7qh/kYleyqsfo+cdU4DJkRnI6qFC8RP/iAekIoxNmUKEPM8h0ARQQ/HavjVZKTOJbYp0
         HypZu6VDmlV6xsQeyc8sbnqmJqGLW1e1IzpLtRW1j7RLvFa3LKRz6uMnvYV/mjYtYP3S
         cyD/spBrUDwS/LPHNrW0ZbkEASRYBouXUGPW6GEPzqFa7CCudPrkzHGTLlNUhK/qMpV6
         Bi0+PzoZ32YH6Zo08QIbK/Ui7Zo3Bna6ZnNGVrq/VFJS4ymeK5O551ccXVfzuq/kYuWR
         z3gg==
X-Forwarded-Encrypted: i=1; AJvYcCVv5QlsAj2wpWEn4EYD4Rgs0t/3suDutM0B95HrGXPfgiSdEjeglFX3YNE2p/+duqQ3WCFOxtgYlrJ4KW8BQcZd@vger.kernel.org
X-Gm-Message-State: AOJu0YxpotG5NZb0vCISiYAYu7qKxTRpQW7b6jwtKz62/lOdFyRvcMKt
	+EDnlXBVR9s9cuKtqCWwflHHsOZB49XG6ZBl/23Bg3ZFU1dVFB3UkmXuppicNN2rcOyJfRsh6Hk
	rMNWaXYZkUZ2D6uudcLdmgow8VXM=
X-Gm-Gg: ASbGnctNoATTBS8a+Bu4VM6PoFTbGEs+nJfVAMs3Cta5I+JxoO4QHMuFtT4Cq6HPbPj
	pXkKcF3kXj/LMc5Kuxidl9e2bzmuq/v9hNLlZQvBox92k9AjYXyZWpV2YoQ==
X-Google-Smtp-Source: AGHT+IFkIzlckJjqegWQr7hYz4mRCSF6eiJiZQk7J2n236E6beZlRzVWg7QdrfYnvpchBnTefvpGiRm+I+O9ko8wBMs=
X-Received: by 2002:a17:902:eccc:b0:215:a2f4:d4ab with SMTP id
 d9443c01a7336-215bd74d102mr60497385ad.7.1733262172011; Tue, 03 Dec 2024
 13:42:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GVXP195MB17582AFEE944316C3F660225ED2A2@GVXP195MB1758.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <GVXP195MB17582AFEE944316C3F660225ED2A2@GVXP195MB1758.EURP195.PROD.OUTLOOK.COM>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 3 Dec 2024 13:42:40 -0800
Message-ID: <CAM9d7cj6Kr7TVGSQsDkRgVv+Umt3gMs=3TQPAcujk+t8Xv4GQQ@mail.gmail.com>
Subject: Re: perf top usecase breaks due to kernel change
To: Franz-Josef Haider <fj.haider@outlook.com>
Cc: irogers@google.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 29, 2024 at 1:58=E2=80=AFPM Franz-Josef Haider
<fj.haider@outlook.com> wrote:
>
> Hello.
>
> The usecase:
> https://github.com/dolphin-emu/dolphin/blob/master/Tools/perf-disassemble=
.sh#L11
>
> For running perf top and analyzing jitted code breaks due to kernel commi=
t:
> commit 873a83731f1cc85c8427fdc7a9e24fb270faca44
>
> What happens is that when selecting a function to annotate the following
> is printed:
>
> Couldn't annotate JIT_FOO
> Internal error: Invalid -1 error code
>
> I confirmed that reverting the change makes the functionality work again.

Thanks for the report and sorry for the breakage.

I never thought you could use a shell script for gdb to disassemble
JIT code.  Not sure how to fix it properly - maybe we can try to read
the code in memory when the task is live?

Thanks,
Namhyung
