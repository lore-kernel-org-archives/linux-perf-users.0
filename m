Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588D216E12
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691816; cv=none; b=iLQfUZJKIeqgZlMqyUuu9crr1Dy1pEJ+wlNZg0tqNfoKAGVgoAnIDxKgnSsha8w7PWg2/t1QUWhvyjynZJSDDF/YY9BRRT45kqiQ0CRDhgz+xLRreaCOIXZvF48hcrw3sh9IvElB6zbP1e5I+nSwdMf0r1MenZogFrsFijWHjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691816; c=relaxed/simple;
	bh=6MfNKqlPY66LdRK1s+sv6ABSkmpyUD/zuxH8o4il5yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4e9Oi2biK91WBdfA+YJIhWTnEYw5B52Q7tE4O13+lwTYD1IMfb8DZ1FxYe0taq54Xdvd0pzYodOtl/4xtgLOeRWdayI7TUibDDl4dQcIF0qlweePirIk7Uwf8l49EUXgHBCrZq4ce3Ok9F3N3wtM5qwYbhC/d4j/dpr8gR/hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6x9NV9P; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6x9NV9P"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so12555ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 09:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738691814; x=1739296614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MfNKqlPY66LdRK1s+sv6ABSkmpyUD/zuxH8o4il5yE=;
        b=i6x9NV9PZxC/hxVZZp1y3iN0ax1w9CIJ68O47lGfKS7vJLkmiGnoiP3h4B1OC9MExR
         jP1RucHlwzMd0THbuzCV4hbuH0TqDhygkLW7zLYQWBhLUfeMOSjAho0MJRUG74UwDsrl
         PmZ5KdTx1WLdm0mGiHULJS1Lk0uvoeWw4RQ0GRk1XSRVeH4a2fSGD2kkCSIIC0CGtzUU
         FnQJ1Lo3imk2KGdhe6ocTLs8yzWLG8kNnSEazoFWA/1hZNhFGfH6okSR15vljDxILOIr
         frfbrHOrMWjW/Z59q3YtYU2+XNEHLZNmQRfEfWGca3fssok5+0xvdCAaK1FblnEqyWNg
         vswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691814; x=1739296614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MfNKqlPY66LdRK1s+sv6ABSkmpyUD/zuxH8o4il5yE=;
        b=nW+Ue58NG/khABogzDxBCP2Vkudeea/gmBu8n6oSt0/IjVUNxoEuTlGfK0Ar7nEFAe
         q6/KN3jHL5Osbi8zeBil0DRpzLkOp8Yswwqi4z+YgNcbXAl0swjFKQIue5MZXPvqV8m1
         dUM9t6UvPCYYl+nj2QWtgNjvFzkOqadmfPVsKjiC5BRFKmJulkq5LnAiRieq1OKaEdYl
         cAmUZnlT/dj7nu+N80Z9oBwfMp9iNq+28hkx/5yRI9RVsb0Q/KbMd/Gvs4CZU4SPFqA+
         b3tmSAN3IUhZRjqZicLRB//JatzPo5W81j902wGHWtUGeeuxlPTGKGI8VsgryN5YNR0i
         i94w==
X-Forwarded-Encrypted: i=1; AJvYcCVgfJpcmI+oZ/o7eUDm2YE/hWKn8+RtiIoU1ELR+U/xtTWKOw6gtgAq3GOLl71vnL74UjdDBQrWlLm0sg2gfhTG@vger.kernel.org
X-Gm-Message-State: AOJu0YwyCwCF+Oh/jH0jhM9eh7VaV99UfY80GYLe0a9SdkL6vWZHD5LR
	casDbMfH25PgU+JKcoK8rr78v7v0zDupMSEgOfCWoE+PbKCEnjSco+soqSyZNMgkA2DBAkxe7QS
	yHb16Jcbk1mZZH4gcIbUVsg4FZraCct93CAOT
X-Gm-Gg: ASbGncvCakd62uI+CSsMCIQlJ7coEC9k7BUE3BqBpvhXSkUb0ZiW8s1zOkuA980Wfba
	4BLTSWen4gaEs1RvMXmSz5DRz4B53OxcKcrcNcBin78h5SJpzN7BZSXVW/KCEYwb9rTW5TB548K
	/6LdieJ85ofrYLIXfQltBK+ws=
X-Google-Smtp-Source: AGHT+IG1acNH4dX8Vb0s5oxx9ddSfzVUNv/AaN82ZPUmm9fX6OxCbLVTvL2daR2maEwM0AH0L4ztS+4bA7GtmkxfApc=
X-Received: by 2002:a05:6e02:1566:b0:3a7:c9eb:accc with SMTP id
 e9e14a558f8ab-3d03fbfd550mr4313095ab.14.1738691814257; Tue, 04 Feb 2025
 09:56:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215181220.754822-1-howardchu95@gmail.com>
 <Z2CJW0vFT005gmIe@google.com> <CAH0uvogp4GB6ZkB=79wCNVtOhsGw-aofzGmW6nPc--b=g-D9OQ@mail.gmail.com>
 <CA+JHD92xXH=6K0-imdObf+dw3=B0uiGdFH16DO3ArdHv3r1Zzg@mail.gmail.com>
In-Reply-To: <CA+JHD92xXH=6K0-imdObf+dw3=B0uiGdFH16DO3ArdHv3r1Zzg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 09:56:43 -0800
X-Gm-Features: AWEUYZmt0EhyS_vNxi6_NAMLvcI8PJ4wAkE-Tn2ZgXvM9XCRHXIsR_7itjC3TSI
Message-ID: <CAP-5=fXRBssmhBZDTbk0=0_qzo6R6f5Kg4BGnE9M1AA2viR3=Q@mail.gmail.com>
Subject: Re: [PATCH v14 00/10] perf record --off-cpu: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 12:55=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Now it's my turn.. ;-)

Perhaps this could land?

Thanks,
Ian

> On Mon, Dec 16, 2024, 5:49=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>>
>> Hello Namhyung,
>>
[snip]
>> On Mon, Dec 16, 2024 at 12:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
>> > Thanks for your work and the persistence.
>>
>> I think you misspelled 'procrastination' :). All jokes aside, thank
>> you for the reviews=E2=80=94it=E2=80=99s much harder on your side.
>>
>> >
>> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>> >
>> > Thanks,
>> > Namhyung
