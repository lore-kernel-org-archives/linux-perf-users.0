Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBDA1BC3C;
	Sat,  5 Apr 2025 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743819160; cv=none; b=DUkaQxRObyrhXZ/sXVtvWq4h4wqnxnhV72M2B8qLXvKxO6isoJKGDjaKQQSFdyG7QYc2J7Z8R9lzh80U3YPpbdGHwd1UiVq56z0xd9ypo0TK0+val4AX/9v6eNcDV0baBCArrmAzsbkliCVVdYQwdMbQ6aRpj9poG7fqQGoxtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743819160; c=relaxed/simple;
	bh=W5Tzc7JfwoCkRtbCcIhlN4rJMkRNvq6L/QweDaUZzpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9D2LY7d3grrtSwA+0R9HDUEQsqzQlMrgGLadBpWzMIygW8VytuQMp1kmo1WbY/wmlqE9uFNVSIY1Lq6NQccCokC1LNWLT7RG7oopWH3MOAHcau7tgkx8Fh3/uOcGThniPVxFV4WvfsogBGZjcsuWUeczAYeDbNN2kUjGOU75Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO3hSEww; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO3hSEww"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7020d8b110aso26648727b3.1;
        Fri, 04 Apr 2025 19:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743819158; x=1744423958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cRBLCNvFO2BQ8b6lAHPXIKGCL8sfpGqe9b8U9EIe8o=;
        b=mO3hSEwwToIBjroR1I6Hajpi8EWqxTgdA9kKkHkgUxwkvhi/43ZVgtsPJaaCJvn0f2
         JO8v9udMAVC7S7fNIrGVVKz0uNimMlXHM4ZJwx+J/zh9BXITz1zpWjAPzOMOXLx/fI7W
         A/gc4umkm08OHn2974KfakwbcQK+sRE9Tj2c8S1ADzXtmvABWuY9rh661EKWBzVKueSD
         vYwrDfOWXjCUS6BkE3l8CwmrtkxyjiR5HZ5FAQfL5JTpVcJzQWzAxwWhLqXScwLif2fp
         Hrq9wcIdPg5fB7nyAuW20LXFfazKsxS+nD0oB4wuBIAPxq0rAjLzNTkM3FTzFAARyCYU
         a8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743819158; x=1744423958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cRBLCNvFO2BQ8b6lAHPXIKGCL8sfpGqe9b8U9EIe8o=;
        b=c3alC9AyjmJm+Pav+uX1wul91UtZUVUQiB+JTObeHUnR1uG++jJ2DNToW3cjXB8yHc
         IINtOlSmFAmQdf44ho8Omgv4BTLvuzbKfXwJthZvC4M/3rgnUd1Wkn+UsmPywzMRAb1Y
         t0VZe30+/rIOiXpItLc3UvdDpvWclhw5ZVsSsmXSQAUQCYGf7uc8unNQqj1eRp3fKtkO
         FAggxF6VliqxgGgANWO9ly0w/7Y3Np0NvB8DpC+4+QVtMKe3dR6bOySHWWIq7kgUKuin
         bsaTydlQcwoAe/yCJ/5QPIz1zoy41YYgp1HvGP0mDXe+HWsgPlPI4kXugKr8TK1NA+/n
         ynRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfqhniX/CACV2tji7LT5kmcQz9/25Td/edlMi7Wwo+Sok7H05C86YJfgz1OUOQXkr+U2xQ3aGsQPCnbw+U0wjC6g==@vger.kernel.org, AJvYcCX6oeCrPyCFT0DqKQKEaW9Vo82FS04b0MaQW+vTPKQJhYVWmpUJzcyspJCHWpdgFjJiGNnrioHIH3Fadpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPFSg2P3w083FskI8JfP2avJpkYav7BKoFcXTV7ym+T0Jgzg7
	xXqPtcsPN4nPNC1H/hr6rTzSUJOsQOsPsUonwA1sHZWWvCYoCHmUIxDFCu+0c0Bz7uSb1p9g+qP
	//jQ8gLoTMtkvmz6eZcTPwFCi+xc=
X-Gm-Gg: ASbGnctgFcnp4sENi+rC3E4Bafb1f5hb/UyqNtJg/GA1oOeZ4CNgimGsHP0yery+wow
	t7mC4sYgOgvO7vN8MIxZf3lFUzo3AgBBbK58zze2OKgkuoQJwfzQ5W6BT+eVn70WS9/HHg+q92V
	gVqTnysDx5wzAFznrHjcvlXR5b72whLvB/0/cBJg==
X-Google-Smtp-Source: AGHT+IEQcZRdLea1/0WnC2nuMK4ftQxEivjv4H1y9ZSeO58vv92QoIjZvBmX74tvbAz4od/7SxnzK62u6IrI9iKhZmk=
X-Received: by 2002:a05:690c:670e:b0:6f9:4bb6:eb4e with SMTP id
 00721157ae682-703e1623ab2mr95514937b3.31.1743819157649; Fri, 04 Apr 2025
 19:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404041652.329340-1-howardchu95@gmail.com> <Z_AeswETE5xLcPT8@google.com>
In-Reply-To: <Z_AeswETE5xLcPT8@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 4 Apr 2025 19:12:26 -0700
X-Gm-Features: ATxdqUEX8pXe9mH4oICRNlnT0EcrLojM4xc4hg4lm2HoaUoTmZqbesT-yiFtNzg
Message-ID: <CAH0uvoiOA654mB-gjWTM8TTtVh+c6DvfgD6dh6VWkxrj7prPAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix inconsistent failures in perf trace's tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 4, 2025 at 11:02=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Apr 03, 2025 at 09:16:52PM -0700, Howard Chu wrote:
> > There are two failures that frequently occur in perf trace's tests. One
> > is the failure of 'perf trace BTF general tests'; The other one is the
> > failure of 'perf trace record and replay', which, when run independentl=
y,
> > always succeeds.
> >
> > The root cause of the first failure, is that perf trace may give two ty=
pes
> > of output, depending on whether the comm of a process can be parsed, fo=
r
> > example:
> >
> > mv/312705 renameat2(CWD, "/tmp/file1_VJOT", CWD, "/tmp/file2_VJOT", NOR=
EPLACE) =3D 0
> > :312774/312774 renameat2(CWD, "/tmp/file1_5YcE", CWD, "/tmp/file2_5YcE"=
, NOREPLACE) =3D 0
> >
> > In the test, however, grep is always looking for the comm 'mv', which
> > sometimes may not be present.
> >
> > The cause of the second failure is that 'perf trace BTF general tests'
> > modifies the perf config, and because tests are run concurrently,
> > subsequent tests use the modified perf config before the BTF general
> > test can restore the original config. Mark the BTF general tests as
> > exclusive will solve the failure.

Yeah, I was wrong =E2=80=94 I now suspect it has something to do with two
augmented_syscall BPF programs running at the same time. I noticed the
offcpu test has '(exclusive)' too. Do you think it's a BPF triggering
issue? Like, if test A is trying to capture the clock_nanosleep
syscall and test B is also trying to capture it, could it be that A
ends up capturing both calls while B gets nothing? Just asking before
I dig in further. :)

>
> I'm not sure if the config is the cause of the failure.  Also I don't
> see it restored.
>
> IIUC the export only affects child processes from the current shell.
> So other tests running in parallel won't see the config change.
>
> But still, there should be something to affect the behavior.  It's
> strange to miss the task name in COMM record.

I can look into that too.

>
> I also confirm that running the test serially fixes it.
>
> Thanks,
> Namhyung

Thanks,
Howard
