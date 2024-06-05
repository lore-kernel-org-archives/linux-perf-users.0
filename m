Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384E036C
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Jun 2024 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717546306; cv=none; b=pavItqZlDiMC5GrgD3o8X0NNfuHBN2F5kjfMqz73BfQJpYozwOr27G0yN3JBXV33Re61KY8H4voNkMVEBPe5cI8mBUlE9t3xVseKk2I43A3+C0bME8JLYrJxJEWt+/NfbKV7l7pjA/6ZOfNCPjqEa5BzAGAP7jEKdVHUKr5rabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717546306; c=relaxed/simple;
	bh=LvpIvl4r98SqFjzuMelyzF8LS3WNvqbNMFkJNsuQDKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kQsFWBqXYI7I+BSX7ReLz2SAtbWMps8Bz5hoiiD1TSYcI+FX0i88mUmmbWYCrNeO6dvyrJ9GTD6Zy5UdMUA/37nnjILbdKBufaesmDF7FttGuDNbUkS/0M+wimN6QuH2W0GLgQ/XHNzFO7aS6iTVk6YpGG5Ek4ZtyJjzP3DYNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eDu1aCH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eDu1aCH"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee5f3123d8so54935ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jun 2024 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717546304; x=1718151104; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvpIvl4r98SqFjzuMelyzF8LS3WNvqbNMFkJNsuQDKM=;
        b=1eDu1aCH36VN82sJkqulzdsmBEsfAZhI9hM8vqGeI8sN62YcyKLxX5kZhwCKJWHg4V
         g+1QWhUHoYcURD93K5ZPXKtE7yjX1I/ZxV2LIsoNZrcXvI2k0u8bTVqi0a14KghaIKvv
         NpevHbZEtzfLd2Htg0TMw2LbXwYZNkwnKqAjpWTec/lkEc8yZtAWdUE56i43iq+Gr6jq
         uuq9irBdsT90pWhomq/Mi8H3BU2AgqA5bnrmf+RGC8pye3E3LWohVxn1MnBixJoeeRmV
         Tq2jyxoLqo+uNNhTrC/f8zDfBimeWBK+U/KaWhO0o+wDHBVCYIx3BgBIiCU8LVyyEhyp
         1kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717546304; x=1718151104;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvpIvl4r98SqFjzuMelyzF8LS3WNvqbNMFkJNsuQDKM=;
        b=jqXmFzzTFeW+HGLZbul37XaONc0Iu2yjtwoiSOJnOSLsxR7mcj3+bL5gVXs6XU/sdd
         GPcqw8cKk76HvBY8qA6rr4ri0uWTHV1OG9j4BzK2GFST2elYB2kvKelfhg+MwxcnA/ez
         KsdIm16/PGLlfyRv+qi7Z1lceiXOhUxz6i78YIsnT9I+fyLQhGcTO+iterLqDsduok7x
         kCyp0uPN9pe51sR+9rCUCXIWdxZlvZJXyPKc2jeN3qbokMWHEcenASRwBo5lPA6ufHmF
         jegZ4WTuZh3xyQf9fYAkuEJ1tW3W9ON8U5qzQKEnrFUBtD5zyIqZXHBUWbMlE3SzTzQ0
         LsJQ==
X-Gm-Message-State: AOJu0YzYIKNxc1mBQVVwJhgMtDx47tM9Q4ay9y4XHyZXQfaqeiDuA7a+
	HI1xjijJ2i3lMuZeSzPUPDBi5KnlLyFV6Cm/glo/WF+6fE5dwzwWXMoYk77TsUhItJUr1kLODOx
	jJzcCMR5m6wSAS2Yky1WGB6Hre8VyDWsGsIZYjw6Vs2bd5Z1zb6+/jkE=
X-Google-Smtp-Source: AGHT+IHgIRvZGm7kb1NqcasxsLhjouBYCyNeBR4fLwzWJ8z+SoRel4/vf4Za4H4m6yaGgEvJar4txS5mH9NQYSHRu3E=
X-Received: by 2002:a17:902:b714:b0:1f6:858e:1688 with SMTP id
 d9443c01a7336-1f6a77fc51amr609535ad.11.1717546303927; Tue, 04 Jun 2024
 17:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
In-Reply-To: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Jun 2024 17:11:32 -0700
Message-ID: <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2nd week of Google Summer-of-Code. Office hours this week are changed
from Wednesday to Friday:

Linux perf tool office hours
Friday, June 7 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian
