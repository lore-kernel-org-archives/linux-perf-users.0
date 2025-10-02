Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE67278158
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435903; cv=none; b=ciKzGmNTUPOVn3LpsrLRu45D9pLDHy4Jf4sySvqS83TXWp2//o6Z5J1WKRm7zseUGmlByne21GFBC9iH8JE0GfCADBIJJ8M/l7aG/vr3mVz+aHS5ayaUit86qvdyYMG2deVNtFiS3IBUkbU3AYPHJr2P8K7wXYBB6qgWTIY0rJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435903; c=relaxed/simple;
	bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZEBOE8IYLBHaTmO7MRXbnlnWgU26HHh88tU4RBYPyoXxpdpZZAmxk44ADJlyzRXH5Ou1nFFf9AgAg/P7dgGpK0g0YV6mm6dB7MilbrRiXotmBemGbOW3Q1XZM27FcRXmMKDBpzihF9OfGtOnFQDIaZFzxw2vimIRBzlipYKTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwjKSrA3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwjKSrA3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so57765ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759435902; x=1760040702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
        b=YwjKSrA3mK1AI/iw1tQUMemQjvhwoUbXSyAu+ghnVPr++0Ut/qB8P9D4L+d8dve3ye
         i2DWtKGqGM0931Ev/Pdgu1nzs7RmO4VxvA7O0sKjIFU6ZlKZarOz3iSjBo83KGqsnzZi
         AovWpg/jbIunUVhyXyBi5U1UtIsLPDdJ0Lz6EiGm/ZrtZ7jFekBNzKaxj/gs9BRgQEq9
         I0fb4r+lUhr50UhzuiOxG3LqqVKJd2SwbPSQLOmIZuLgg98UO/PsZP7ZmD2kcoH5pElX
         a6iMbsIIBcnHF34h6i0LF4FCSzgUTOcnk4CWRV1Vid99GNCxgCE8CVm1O3bLS2acrstV
         LDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435902; x=1760040702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Xmptz9A0AZI6GVLqfIYyRp8yCNyKVavpmva4MS99eM=;
        b=sj6fuyIKTlYG+zjZ8gd27F5EAk/2dOThQlMc0pUJlroV1VUBCriVA8sygy7xqIcIOD
         VTAr6GIzjV7p4VIaGLloMUDCud6dwTo0a745CVXV03dBWHW+0utBolQLRB0PsL188OsM
         aiNHVDUQKjzxor0iVGmCoytoSyJ2mUcho3uTnvjW5Bcs7JfIXZk82Dt38rzmMQTkRFKn
         wzCfgsDl5c6Zu5U/iv5ngOAQWG6BNJj81fmIPcxk3NHE0kJ7qBpS4hBNAA3KBfPAOcgB
         ugk8aeWCmfX/YyH2h+Yp3syxcphWPMIb1Ko5jz9pLeHN4V2SNabx/Nb/5Twy/4HZCUwu
         rNEg==
X-Forwarded-Encrypted: i=1; AJvYcCXp+6gwQbzheZGlXreeIYGcoN5mhG6pYnP1sa+Bx2h9ANb9ydOGJxp0WrIhaUFyC9My5KrfFwdOtiSwwPvBxeYY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm+3nHGehZJVAexEuLSwcavmnuZBb4BauWV1B6+xoRztgARb/K
	trhfnO6emt5KmHEdaFz/pECfNN7vZMlvnF7m6JrLhIgPboNDz8t1YDmNEmyWoid2t9CScdff7q7
	Ym/h5JCx5FoJ0rSHjwBGfsY1FuAN9ajr27ogXdIqL
X-Gm-Gg: ASbGncuGMj0KfVAA8S1L5At7roLNy0T3GaWd/OKPDcPUZWjpud4KbaxEMbzMdirTJYh
	6QM8LZvCD231N/BjM1XDvsPNpc1/QBSHnTqYfqmxoexGfllhKVYHAFd0WC2hMsSotfeZrLY9PFI
	x0BW1FkgrwCJPQy3z0Gbviu6iicEWY63nlFKSl9GmvzQMpzrXGuFFZ4q5fVj4a0K93lUS5XHAcL
	N8VU7PSLxysUaGtZ8pqYlouCo+1tFFmkB7Mgrj9ka4pzxGe0BOjqDA52QWxbYaYa2r7
X-Google-Smtp-Source: AGHT+IEDnv7xA6yTgSjXYL7xRPt7GJqeog/t9tQkEO11Hq9eG3As031Vk1GqWBEZmEqKXPhJN17IuiX62dFIfHEg2yE=
X-Received: by 2002:a17:903:38cd:b0:25b:d970:fe45 with SMTP id
 d9443c01a7336-28e9b5b2f2bmr118665ad.1.1759435901284; Thu, 02 Oct 2025
 13:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com> <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
 <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org> <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
 <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
In-Reply-To: <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 13:10:58 -0700
X-Gm-Features: AS18NWCOIOOooIYNzhifJ_WElQoGyrFKUK_3pLXugWDvVz-KeMpwCHFzRx6va4g
Message-ID: <CAP-5=fX0bOj2kEJYmRs33RpL0ODaOy2wCvDzwLDmNxurVRpGew@mail.gmail.com>
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
> From bisecting, this change came from commit 9eac5612da1c ("perf stat:
> Don't skip failing group events"):
> https://lore.kernel.org/lkml/20250825211204.2784695-3-irogers@google.com/
> Taking a look.

I sent a fix:
https://lore.kernel.org/linux-perf-users/20251002200604.1792141-2-irogers@g=
oogle.com/
that makes it so that only if all events are unsupported that perf
stat exits - this is addressing a bunch of latent issues and fixes the
perf-tools-next regression. I don't think there is a difference
between v3 and v6 wrt this behavior, I think you were probably just
cherry-picking the v6 patches onto a newer tree. When those 2 patches
land I can rebase this series on them and drop the first patch of this
series.

Thanks,
Ian
