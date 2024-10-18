Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C1D1E96
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729266549; cv=none; b=tf/hcNkOpM4JeXNzJe6cfcLNvOY7BqyCvbPJqzU8Y1J+N3YVNO3X54E0/CVlPxwR/RhP7HbExlP8rlbCmcADRUS0XjN1HYaram67c9ZGMnhl8y0Uv88Z/8PG6Q2HuPKVDHTnhw3NWBhKmyd/YPbNabU70hhzi0FYS6UTcIyV2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729266549; c=relaxed/simple;
	bh=BgmzIY3kGULr1QWfbWRub0ZKXkdclNfLCw5wNfJJrYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzvgoDKRJopiRVmeqEvzpm92jAZjN5J61cTsQuywn906i4/CGZDdNXyI7nUIuBStQXCNFY0an+NCGPxI3jXESsxYwFKZRI1u3775/hl2Udl8AClKoatoym9qSLOd+WI8vrewpJxnXVd2EiG1Myk+5GH9QR2Dy0ofz1K/Tolw3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLS2QvLf; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLS2QvLf"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso237465ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Oct 2024 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729266546; x=1729871346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyA65vYYqkGpQYYXil55YtRI18xwltFUUTkGJHKMDO4=;
        b=hLS2QvLfGxstbJOS2hzGn2p5RbutWYLPb9AUYLvL9lUrJBri0onuis4TP/fRNqMTWA
         8ZYoM+c7K9PjVJQs7WMXI2lyHS9v9lrdo0Ak5acF8ledxIVmv6ox7l89oYY/cFQPdTgz
         FsAhlmCfhSfVunPB6dh22ayvl16W5QSgTWrdgbSLrHaoZHCRveGQ9OfyEskz3GqpguHf
         jgPDxCZtiUQOgTVfFVSU/S9YXMkZkL39nTHkPYuUwfh1Z0wricMNicaj0/G85YKyDw6W
         6HlIivBkmHP0rjPQLyKgpqgIjSzOzB/lRRNn+f7QStSEvkzu95Avfm2UZeaIP34eoGts
         EGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729266546; x=1729871346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyA65vYYqkGpQYYXil55YtRI18xwltFUUTkGJHKMDO4=;
        b=HqXhn+AMTHaMSipETVSJlOCIoGB5k9DhL9w/9FJUeH0YpdHXI2zHcicM44Z6GaeuVk
         pNqaZdZK3SuJb9PZ9dCVg27MxOETyH6hU6PlQeoxxqMAzvYWXSBRc7vYpvnmGWyZi0MR
         sfJ+nBhP12dOol6JDHxrQ2QUFW44E2MobeqItqCivB0mmL0IZDHllEIXh6RCtGlKMfBp
         ZoYlGyxoAXz/uUy00tYPknMI014N/r1uJ3yRD//q1pErPBWPI1dHlj6lETEFcLCmgNuG
         0QUPBXliufxraX7GMgsgiVBimRsWYV1+Kf/K5Wht/prl/Mz5rUWxqRjmrDLCakTnU6fT
         W9rQ==
X-Gm-Message-State: AOJu0YzisT0guOVpqVy7dQoB6kvrJDBXh3ZNunRpUbNoOAJf4W5MToDD
	gTJaYl32N+feAfydr8Q2JVkx09W7PjvItVHVZTnT9iNnYLF9QoTrEr1CyUSx0XKkXY1p948hyLu
	sgH8HHnx/KoHRBv0BGpXDUT1B5F6t6I22VtNF
X-Google-Smtp-Source: AGHT+IGBiBA5oyJymUOS/HHmvQLXekemn1RtscTcxGjaEY+msWJaXN/wIH4+jo9XYM9cQKuja4JWRp5lP2ysL4vbc3c=
X-Received: by 2002:a05:6e02:1fc3:b0:3a1:a90f:74c6 with SMTP id
 e9e14a558f8ab-3a3f41381c2mr3504525ab.21.1729266546405; Fri, 18 Oct 2024
 08:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729242778.git.sandipan.das@amd.com>
In-Reply-To: <cover.1729242778.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Oct 2024 08:48:54 -0700
Message-ID: <CAP-5=fXWPwvHcx38Cshha9xP50hKTTZFUxiH7+yG4u=z6sqvig@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Add more Zen 5 events and metrics
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, eranian@google.com, ravi.bangoria@amd.com, 
	ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:31=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Add data fabric events and metrics taken from the now released Processor
> Programming Reference (PPR) for AMD Family 1Ah Model 02h Revision C1
> Processors document available at the link below.
> https://bugzilla.kernel.org/attachment.cgi?id=3D307010
>
> While at it, also update some missing or redundant data cache metrics.

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Sandipan Das (3):
>   perf vendor events amd: Add Zen 5 data fabric events
>   perf vendor events amd: Add Zen 5 data fabric metrics
>   perf vendor events amd: Update Zen 5 data cache fill events
>
>  .../arch/x86/amdzen5/data-fabric.json         | 1634 +++++++++++++++++
>  .../arch/x86/amdzen5/load-store.json          |   78 +-
>  .../arch/x86/amdzen5/recommended.json         |  112 ++
>  3 files changed, 1818 insertions(+), 6 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.js=
on
>
> --
> 2.43.0
>
