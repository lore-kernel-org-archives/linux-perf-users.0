Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CF1448E0;
	Tue, 25 Jun 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338397; cv=none; b=dmyu4wQlCEkbO12BJk6rOYVVsuXF+oJ8fTOgiap9dkfd/rocFHwCbhW/JaCivwNIFw7tyPrHrhHI2nISVh12BoodYpO19i7V90G4TleYV9LEvCn5WcuSqonuPK+OVjhGHkq/JkN+W4rS+K2vTRi0xvAv+lBtF3EXNmkl8oBqqEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338397; c=relaxed/simple;
	bh=hpOYBpdg6gThR5b1N227DpI9cC6+qivPwLINqm+V7N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ia7V9ZLNnY7y91AQCxXJf9OROUKZKOgjUnAuK3cpuLhRMekzIAvovUWcTIqxLj1uQ/7XLF6UIZYheDFTZ5/ddFwXEMK3XEc3Fq1aXp7jk5imS8kpkhRcKY9IhYSFLpjSJyh6uux0UaHhBoAXEKXVleIIuQGTNLJfbF4eXMcMvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6e3741519d7so3984518a12.2;
        Tue, 25 Jun 2024 10:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719338395; x=1719943195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5PoShk9ER6oKuETO3bdJUevSzjYujmcfx3i8qQ0MKo=;
        b=WyGMrdA1r8KVw5KZriQ0MtWosR81TcjYDQKVJdCzqi38c88RvqtvuCFa2YQMJjImU0
         NhdKzlm2TPFbGbQbjquq6rRAtwjnU6gtDKpG961FxsIyQxXSUa4ZqUDPDjLdRMsv6Fl5
         qZx9F/JNL0SQi21uroe/TkDmF3MwX5Gw2CLbbkYkoZDa9x0biw/j2P3xlaXI1OIy4S21
         mVNyNB/evfFj/je5B1ZdavAST+q+0XgHLN6oN3WIZDdShYvoEioL6QJATWvh8IhiMDao
         wor879eeOQmUbu8/rNZxJGoaa3bqTns6o5gbus14vVenrjyg05sgkTIj9u8pCnfJS5Lo
         MPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV47idPos36259TTI4SPksLk/pFt1qiNN+bU9QbaV+Fs5w3qNRSS9m+8H8K2rfpG08hj3cHuccFv4YiXS3xOl5wQZuNYkEKU/rEtGEb44vH4kPSjskPqcdM7MfbHcF661Ed+ZmZBEl3Tz5QLPM8Yg==
X-Gm-Message-State: AOJu0YwAr8lgeLJAwCYv7yPiUIqj/K6kHlni9jkDFRGVAO+HqIjJLkiD
	zc3ITFOd3WgtUGDSeF4as0zxH5tmHHMg5MQ6mMEhBkNVVH/U6G0ycNfiHLOehOOXri40ajZkOmB
	vCbnjWo29p94lEPtf7XYe2V/PAio=
X-Google-Smtp-Source: AGHT+IGG+13e+IM6YaHCDjgHhxzZwK9iqPFhSJtEBdaJ14Pj4FVkbJjvKOBZjXrBtApOOtBEaVA2FM1ujUiSxA6mseE=
X-Received: by 2002:a05:6a20:7b1b:b0:1b5:5ee0:378a with SMTP id
 adf61e73a8af0-1bcee771ca1mr7839615637.36.1719338395163; Tue, 25 Jun 2024
 10:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
 <722cb4bc-89d4-4e03-a80d-ffe05be52c05@intel.com> <f65ff3cf-1724-45a1-ad88-200d72251042@intel.com>
In-Reply-To: <f65ff3cf-1724-45a1-ad88-200d72251042@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 25 Jun 2024 10:59:44 -0700
Message-ID: <CAM9d7ci2raJmUjb7X2m6O1mCJm5xYLEWS8g_gC7tTjvshm1XFQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	irogers@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	akanksha@linux.ibm.com, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 25, 2024 at 5:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 25/06/24 14:57, Adrian Hunter wrote:
> > On 23/06/24 09:48, Athira Rajeev wrote:
> >> Perf test for perf probe of function from different CU fails
> >> as below:
> >>
> >>      ./perf test -vv "test perf probe of function from different CU"
> >>      116: test perf probe of function from different CU:
> >>      --- start ---
> >>      test child forked, pid 2679
> >>      Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa=
7iy89bx/testfile
> >>        Error: Failed to add events.
> >>      --- Cleaning up ---
> >>      "foo" does not hit any event.
> >>        Error: Failed to delete events.
> >>      ---- end(-1) ----
> >>      116: test perf probe of function from different CU               =
    : FAILED!
> >>
> >> The test does below to probe function "foo" :
> >>
> >>      # gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7=
/testfile-foo.c
> >>      -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> >>      # gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testf=
ile-main.c
> >>      -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> >>      # gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testf=
ile
> >>      /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> >>      /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> >>
> >>      # ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/tes=
tfile foo
> >>      Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Xni=
NxNEVT7/testfile
> >>         Error: Failed to add events.
> >>
> >> Perf probe fails to find symbol foo in the executable placed in
> >> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7
> >>
> >> Simple reproduce:
> >>
> >>  # mktemp -d /tmp/perf-checkXXXXXXXXXX
> >>    /tmp/perf-checkcWpuLRQI8j
> >>
> >>  # gcc -g -o test test.c
> >>  # cp test /tmp/perf-checkcWpuLRQI8j/
> >>  # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
> >>    00000000100006bc T foo
> >>
> >>  # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
> >>    Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
> >>       Error: Failed to add events.
> >>
> >> But it works with any files like /tmp/perf/test. Only for
> >> patterns with "/tmp/perf-", this fails.
> >>
> >> Further debugging, commit 80d496be89ed ("perf report: Add support
> >> for profiling JIT generated code") added support for profiling JIT
> >> generated code. This patch handles dso's of form
> >> "/tmp/perf-$PID.map" .
> >>
> >> The check used "if (strncmp(self->name, "/tmp/perf-", 10) =3D=3D 0)"
> >> to match "/tmp/perf-$PID.map". With this commit, any dso in
> >> /tmp/perf- folder will be considered separately for processing
> >> (not only JIT created map files ). Fix this by changing the
> >> string pattern to check for "/tmp/perf-%d.map". Add a helper
> >> function is_perf_pid_map_name to do this check. In "struct dso",
> >> dso->long_name holds the long name of the dso file. Since the
> >> /tmp/perf-$PID.map check uses the complete name, use dso___long_name f=
or
> >> the string name.
> >>
> >> With the fix,
> >>      # ./perf test "test perf probe of function from different CU"
> >>      117: test perf probe of function from different CU               =
    : Ok
> >>
> >> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
> >
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >
>
> Although it could use a Fixes tag
>

Thanks, I will add

Fixes: 56cbeacf1435 ("perf probe: Add test for regression introduced
by switch to die_get_decl_file()")

Namhyung
