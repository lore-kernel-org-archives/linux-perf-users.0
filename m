Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE87B4501A
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427069; cv=none; b=CVKskLYt70KjcHNeKZOgBBh6eJJhP0yZqsVkO7sg6SsiC94hzNE7HotSlnJr+QKt05hbFbBR48nr+85Y+aWIYnimh4mOr05Pg1n+xdU24Aq2E5ZCm/j2ti1zZaUpGtjcJG7PAW+HTGEhZjz7ePSJWZja00ba/Od1KGl2yZWzWX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427069; c=relaxed/simple;
	bh=r3fMKimlOMUY/oN3ED9zSeONsQeMQTcdndVgEe5eV1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4/1+YiDrCrIM6B6kT0PTB7RiNkSpgoUcxc3lx2SL0xWQRmKIYL0rOSpgwa9bLZM7YUah9YVTmsV1VM/X8XJULQnei059bALcsabK/h+TnX66uYtdyLWwGMepzowMGiJWZty3D1mOiNm9u8n6GgOfZzeSu2AJsdYjNfPUwNdc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRy8B+2N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRy8B+2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759427067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3fMKimlOMUY/oN3ED9zSeONsQeMQTcdndVgEe5eV1E=;
	b=LRy8B+2NlmIOp13BlcyvyPGPZ0KLiJSQc/QujOZVuodYYOhjSrI8rCOj3qsw8NasQcJfUe
	zfRUN+npyOMHOE5M7y7s4jrTxqK5H4SSoAF6q1xU3TJ+z0M7MVPRds6Rs6/jIOrXu9pt9N
	1oYMbA93iQVwL5GI7CmgcSTdk3LY4+A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TWpMZeUcNq-G7rHZ25L3Lw-1; Thu, 02 Oct 2025 13:44:25 -0400
X-MC-Unique: TWpMZeUcNq-G7rHZ25L3Lw-1
X-Mimecast-MFC-AGG-ID: TWpMZeUcNq-G7rHZ25L3Lw_1759427064
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6339aa08acfso1850621a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 10:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759427064; x=1760031864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3fMKimlOMUY/oN3ED9zSeONsQeMQTcdndVgEe5eV1E=;
        b=o28+jlOxOwkhpi53DN2zU9k+CveMztC0kO+7UrFjgcKnZvThAecyJTEsE+8KPWYYEH
         qdOzgWLPFx6Plr+XZ3QxotAxSe+Nx/AomRlAuVn/H+aje80hXzafsq6XCFVTbWYOohhO
         GPhNxGQF22fhjHn+bgQbvBJWIksgQgXDDkukZ0sCf8XZIo6JoyroAh52vHyj+dmtequv
         aY9y9GOfwoOPTg5meUqr45ygRAGwR+QyFNT7ktEqOYeybBqohcFkj4lnYiSltUCt7bx9
         2uHItOnPxwa7aSznaRihK9BWUIcubVf/tma83g2JnQIO8l959/AHRYJKLXVw89NL/BME
         sjng==
X-Forwarded-Encrypted: i=1; AJvYcCVBzzOxIX8nRFV2JFi/ld7qA5c1zJOQwPDF+Ek/4iT0FYoeIEn2eByAJGg5BAutZMbzEgZebL/U9TnVySoMu74g@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbSIIVhoA2KE9wnio1y4LvjZMCDFlRQnoRGMacvt+E7m+G+i6
	jwDWH3saYHhlqbvKK/jQrRGptjMxF/yrtN5XkgZVj8/bwrF0Dxdy3vvGnY6LXThhq/g4VE4EvqX
	mBM/FleFpL84Eqt9RzzCJLnlSjpdtoUzerb8LSWdNCBV8q32ccvKxnC9HC/v4mr84I76sb2EE5i
	N+e6BlyeqH7cIAJ8mi9OUMlW34LjemJAcWkfDBkpRVfLmRaw==
X-Gm-Gg: ASbGncsrU8wUEZeXiYSbZ2GNkU8pc3jTUpuTCFdMBXSR9/22Tkm4c3d+RMAFIBBhDiO
	k0DYNHVdjfdbToz1Kp/KprqLY1b2LSUyqmoqAywB3qTYlg20G6+jQuLrU3Ei7w/eqeMOP/rBtkB
	SGTU/BHvEg7lpEumkMFnGl8avASRL2Sh9EJtuEWJ9JwiDUDQzWzG7Ir+phSqM=
X-Received: by 2002:a05:6402:51ca:b0:634:c377:e1ae with SMTP id 4fb4d7f45d1cf-63904eaa615mr315934a12.14.1759427064144;
        Thu, 02 Oct 2025 10:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs/9DWFZZ0oJV6iT2xLo8FEhrEMcJez6ZFwqbzwuPrj6/TNTGaXH69OYNv1wJl3egCCXCdykeC5j1kCqn22tc=
X-Received: by 2002:a05:6402:51ca:b0:634:c377:e1ae with SMTP id
 4fb4d7f45d1cf-63904eaa615mr315893a12.14.1759427063629; Thu, 02 Oct 2025
 10:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001195047.541745-2-ashelat@redhat.com> <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
In-Reply-To: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Thu, 2 Oct 2025 18:44:12 +0100
X-Gm-Features: AS18NWBMB0KbrxSttrWwIsBvqsjjM-I65ZUl2D5gCwpI_-aP-VRPcv8PM7PtE24
Message-ID: <CA+G8Dh+w6SGhd1B1ad0sg4fcBXrxdbHH9y_5JYJkkuX6gqn8Rw@mail.gmail.com>
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Oct 1, 2025 at 9:44=E2=80=AFPM, Ian Rogers wrote:
> If cycles is 0 then this will always pass, should this be checking a rang=
e?

Yes you're right this will be better.

On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
> Can we use a larger range to allow the test to pass?

What range do you get on s390? When I do group measurements using
"perf record -e "{cycles,cycles}:Su" perf test -w brstack" like in the
test I always get somewhere between 20 and 50 cycles difference. I
haven't tested on s390x, but I see no cycle count difference when
testing the same command on x86. I have observed much larger, more
varied differences when using software events.

Anubhav


On Thu, Oct 2, 2025 at 2:39=E2=80=AFPM Anubhav Shelat <ashelat@redhat.com> =
wrote:
>
> On Oct 1, 2025 at 9:44=E2=80=AFPM, Ian Rogers wrote:
> > If cycles is 0 then this will always pass, should this be checking a ra=
nge?
>
> Yes you're right this will be better.
>
> On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
> > Can we use a larger range to allow the test to pass?
>
> What range do you get on s390? When I do group measurements using "perf r=
ecord -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I alwa=
ys get somewhere between 20 and 50 cycles difference. I haven't tested on s=
390x, but I see no cycle count difference when testing the same command on =
x86. I have observed much larger, more varied differences when using softwa=
re events.
>
> Anubhav

