Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEEE194A60;
	Thu,  3 Apr 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704114; cv=none; b=TAycStj5XbKb1yaq3Q95tJ5tZChhV5YapG3LU5hQujLlMI8wBrZeRs+3h/cnl/Duio6ECXuGukWfedHqLENZIOtX16Tt+KFzvqcwGJy18CGMcEaVhdfGc9XI52uq/Gn33AQ7VNisx97OHa5wKt75NlQy25hTMfzCac3tXFi4OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704114; c=relaxed/simple;
	bh=rRVhtGh3AulVpXsQ9Ior90tc40Gzb3Z5ecni+64VPQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdkK2uBonhHDuTeZ42Bh9oVCblbEZv5kmLTQ+jA3vvx4CwZ1kII7NXDgwlRI74m1tXfdnfu+0dGAHLLjQoDleGFHyHNlkpVN7ujkCsjfL1gPdmDFtNx7nsyw3CaiUQwtoNmQrKrFoblABovSyJ5G0KpZ1RXpB3TXuhHTnfEjH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAQiyOZx; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAQiyOZx"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-700b17551cdso12893147b3.0;
        Thu, 03 Apr 2025 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743704111; x=1744308911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uE3aFQo/JI7mQl7ukF0c3mFPyIPMYG7jo4r7qnoVFk=;
        b=LAQiyOZxqKf5k5+Mr+riT2B8FhLeiLrUG7xjtOqQMLOVNuk8YM4rSLXEWHmuzTRy3A
         HBqx2Sj3Faby3lpq7r7uj/SSvE/6ETAt7jQb2nvYrGoxRk2M+nLMqjpijQFW2QNDlcug
         zh1hJ2pAopG5KlMaSpOgOM6742X6E4A4qBt7ILolgc31fzTqEnft2Lq6KhVZvCap+iJQ
         J73Sn6vEIv1HDxHCHpRcPs3OFhaiqra5g2K9pD83ct91Yu8wez0ytI1hz8cjJNb9iNGO
         Yrt/TNDmFnDBvrvL4Tvzf5H7xXEpIaaLN3CgBufqpZSd6oEhNYFqWAPQTEbsNDbcLOwW
         jVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704111; x=1744308911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uE3aFQo/JI7mQl7ukF0c3mFPyIPMYG7jo4r7qnoVFk=;
        b=ryhvl2iaKogBX/wUzMOphWp4t6jPpt9+xeBfJ0AC5548CPnalk9z3jh9FGs4Z81voA
         9lc5zSkqDpbYCd2lwOg3rWlb1Q5ZPUWAJGQExZLU7nIlnPqLE7vVIvMR1uwfr7MaJhvj
         33LQpC0JTk9xbC9yMOD6f6jhtYJZQW+z2flvnQKcrnDlYE6oqX3knaW+kcV9NSySaU/0
         Ljhk4b9sR+D84AWVJpApkw4GaXVvig/ji2hUYWko8sOTWbnbYXU4dEUG9cDpuzj8RN4J
         maA37iQ1odsv3TLj141ExRWli9QsVR9cF9GypHbfz135gb+hKKUq41sLZnEucHqmAvHp
         B10w==
X-Forwarded-Encrypted: i=1; AJvYcCV7oT6ZT3etW1m+XWHe40be2kT/ggYuLGB8R9o065bNmRudYVyzwIvvq/GsNcjFGWkHWh1ZaEt8Oe1659I=@vger.kernel.org, AJvYcCXG8uyACYYXqfVnp62xRWzjUJwp2yJ0CC2gBbrCDqElGQ3tlujnZ7xSfbm9CbRbtQu0oPsuNhNxcPi8b8VXFhx4rw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw87X3BokdJNVrowklJDpkIC/5m4yPMzVfaYHn4af+mBBp9F9M+
	41mdsx4v63sKdINgHD5GNqHr/F+VL4+3+DFsEpsPzZTktSiKjD1N4kFiUC4LTzGnOsgWq2sX9HH
	8WafdRM7zZpPgvSRt2gaCpL1v404NgTTgi60=
X-Gm-Gg: ASbGnculDgypw+VWEJHBPoty2MrCoroXzKZxlLXkOvlGqVDq4R8QiTJmwfxj1sCRz7G
	wWijZJ+kItcp2fWJxDs3Sb0l6I2XCpiTGqY1ezktxAlBOYQoxiKATwPWAdHfL3lRJMxwh2AY5zU
	Ysf+38lKbrFy71NqGv7ocDBOsfHZq1oJMOizE=
X-Google-Smtp-Source: AGHT+IHiP2PLgiMrCDRFtFfgIYug0xj0fZpwJhKvuLBt5xK1tP1FbYVxFHAFgFqYbzkMVRiQwqqe/ZffXNy/m2UVJxA=
X-Received: by 2002:a05:690c:3583:b0:6f5:2793:2897 with SMTP id
 00721157ae682-703e16337b0mr7113347b3.30.1743704111436; Thu, 03 Apr 2025
 11:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403054213.7021-1-namhyung@kernel.org>
In-Reply-To: <20250403054213.7021-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 3 Apr 2025 11:15:00 -0700
X-Gm-Features: AQ5f1Jod16r8n3FvwG7UOG2-LQ7-fGy3XVVLTynYlGrqvZKv7MK5SW_57SUg9lw
Message-ID: <CAH0uvoh0HZVs3-3w6dWjUHQShq+QzMiF1WirBDyWU9BTfu6sGQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix some leaks of struct thread
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Apr 2, 2025 at 10:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I've found some leaks from 'perf trace -a'.  It seems there are more
> leaks but this is what I can find for now.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
