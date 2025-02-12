Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058C271837
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338879; cv=none; b=e/xiQPQodAcnqN6tTHqX+4kZwUP1WbPORniXNFDK19h6brC0wi+56OZbj2HucRbdfYNs09Ybtn2LPJyBAmL9zF6OpQhXlWkxDPqaBpfLdUUwu+DbIIJ/ILjkzRFpnOHCclvLBHjCxSer681ZO9dQVGZkXfaod1RjGL+js4o+nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338879; c=relaxed/simple;
	bh=lrCwj0QWTxYw5GCNQQjDASwerqlc8xsiCplpiYbfymk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxQySyea3m5qReaE5UWhjROjfk+Ix3omrRTAd85BgJ95SeRWA+Qc2RkI7znc0RggEYCEa1MLiNP7NxQDl8neePY66f9FgETTer4NcoNH2zmmKMKUksM8rRgA9IPGbY9g0CGLOMIsfbXAPliYhNqxT4u2H4gLwM6L0B/r1nDmcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrQuzSUd; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrQuzSUd"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d146357fb2so74285ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 21:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739338876; x=1739943676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrCwj0QWTxYw5GCNQQjDASwerqlc8xsiCplpiYbfymk=;
        b=vrQuzSUd27ySGX9HlZNsVn2jN8fCnMin3WbePKeGbrSxu6iT8CUuQS/O+GQ0s7+fTO
         EMuZnvfzpXQOvFF9Fz8Qp3T74OsS3DeMDvCg32U+FiHL2FxFJ1+osieo306yYEvrlsYy
         EpiTwvwin5SX93eifE2tCNTRKmBOfkrR5CONn0Ss4o7J2Wda9tVFC2nMUNzppD+QakQC
         0FK8LNyRIwwH+uSZYnvp8hw/H5kJ+eMcRlFKeHGPeQO3UQkzG+WOc7XKAMEDgqtlJQ6v
         nxFZfx/vPwT79LKm3hNOB2Ag69s8ptaA/twit6c81V7OCVy1nCTII+OwyFyoYHNFvkxA
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739338876; x=1739943676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrCwj0QWTxYw5GCNQQjDASwerqlc8xsiCplpiYbfymk=;
        b=BSI5+GqIg72Migtmrg/i/QOHGdV+zw044YuZnjpp8aV0EgWOZ1Ckq4cMwvQbdMaNEa
         geV/Q5ifTjCUTknLvI4qKGLZQbWl9ldJ6Q/vULINpOtmZtgpZF6qtixzN+kEXob+UDJx
         N59RpsE6KNI/kRwlmrgP3NIDxn0e8Ht8ERRXcvkQcLA/9KSJbrZpKZV5tlr1lFFMWBIQ
         V23gJzqeFud3STx0sWaQS3yP8LHsdXgO8uSe1+4qT1E5PjvumoGr4uHglE/AKKEkIMVy
         plVv7Ky6oyzYiYgSjsFSgVYD36O6XER1bhcKRdTiqJ250tNTpSsWlc/TXK7Dm0OJMVso
         OT8g==
X-Forwarded-Encrypted: i=1; AJvYcCXfl7vkLc1GA4bkZnhws56D2Jf/CJHZhd9Qa6Eb1L3SCGmLIVdQN03su08gdUq+WJZhQre3EJ7EAi3UdniOu+GL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7n5Ces9cZ4Wy0hb1XRDoff3iKSi7EUg+o22BLcqQPzSkomHNd
	ge3PlxBqaL/8flV5Hf5fNkYVxFEx660mTj/TrHDXdojT9ieOdDpr2ve3sf4pNaJiy4E4YzzIn8p
	+bFhK/iOsAhBx8TFkWMfK9SjtR0zDyUbfZauo
X-Gm-Gg: ASbGncvq328Gldlws3ma8L2Dqw2zxB6UKfhhzAVwVNg7c5JYpsIGizPdmWGZJhCo4tm
	bnP+Moax3+vUWtdUJtcWMDAes7Csc2lEjWuZQrxLP1fXDEaaHZT8KTLl0bgEQI5Svi5NucgRZEw
	==
X-Google-Smtp-Source: AGHT+IHjBddbNj8rwPgLIvjundfD0Allw+yhluJmXHnEBBiuIX94ZBN9EITNF/Snf/FzMt5hrjbEdc3HXy9ombKdv4I=
X-Received: by 2002:a05:6e02:1a8a:b0:3d0:5855:85a3 with SMTP id
 e9e14a558f8ab-3d17cd685bfmr2368595ab.8.1739338876426; Tue, 11 Feb 2025
 21:41:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111190143.1029906-1-irogers@google.com> <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com>
In-Reply-To: <Z6v-mPJq6m61pFA4@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 21:41:04 -0800
X-Gm-Features: AWEUYZlVN_WAQbADyA3JgKBtpSLHRYp2ex5YFJwhA3tIc-ZpokdAvkaWqSomYTs
Message-ID: <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
> But you removed non-BPF and non-root (w/o pinning BPF) use cases.

I didn't think this was a hard series to understand. It moves the -u
options of perf top and perf record to using BPF filters. The many
reasons for this I already explained:
https://lore.kernel.org/lkml/CAP-5=3DfUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2=
hiUFRDA@mail.gmail.com/

Your case is a user that isn't exiting and starting processes and
wants to process themself or some other user they some how have
permissions for? They need to not be starting and exiting processes as
new processes are ignored and exiting processes cause the
perf_event_open to fail. What stops such a user passing the list of
processes they have that aren't starting and exiting as a -p option?

If you try something like:
$ perf top -p $(ps --no-headers -u $USER -o pid | awk '{printf "%s%s",
sep, $1; sep=3D","}')
this is exactly what you get. Does it work? No, the ps and awk
processes terminating but being in the list of processes causes the
perf_event_open for those pids to fail. This is exactly the same
problem as the -u option that you want to keep for this case. The
approach just doesn't work.

Why not make failing to add a -u option fallback on doing the /proc
scan and pretend the processes are a -p option? So now there's a
silent fallback to a broken behavior. New processes won't be profiled
and the data race between the scan and the perf_event_open will cause
failures with non-obvious causes/solutions - mainly, use sudo to run
as root. I'd say this isn't ideal.

This series fixes an option on two commands so that it works in the
sensible use-case, perf running with privileges trying to filter
samples belonging to a specific user. We can say the patch series
doesn't work for the case you give, I don't think anybody cares about
that case, they can get near identical behavior from -p, the behavior
from -p will be clearer than just having -u doing something similar,
namely failing to open for a process and terminate.

You may hate and ignore every point I make and still want to keep the
existing broken behavior. As I've already tried to make clear, you're
adding to the maintenance burden to everyone working in the code base
as the notion of target is fundamental and because you are insisting
on keeping a broken behavior you are also making it untestable. Given
the -u option doesn't work, I strongly suspect nobody uses it. Do I
worry about this series causing harm to the people who aren't using
the option? No I don't as there is a better opportunity in having an
option that (1) does work and (2) results in a simpler code base.

Thanks,
Ian
