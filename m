Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1716D9AF
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716881; cv=none; b=kAYkoZn+WF6HXhjQaXQoC8AgZnVSNl72WplhqUfYft8pf75dFJrW4EdKDobaRl76K97JnhCzMLvYkFTuQwm3+Y679o+onI+NCeLGsmJFoH6YI6UNB7Ds/YfXcuJrQidSQWxHIpRIEnXuJN6bhYfWY8/3utA3QaoyVHT3XtFVIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716881; c=relaxed/simple;
	bh=3yqNDdzLTGhFlyxunbrxQB7ZpJhsygMdfg4hB+E/qsY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LJT9wf/BHYcY0BKw2qZQ+eLEvX2wXqajAU19L5fwZdhDlnPX7jTgNUbSld5vpjEHudOtY4at5yK8lStELLRwOrBb/tyyohv65lC4QJN6dbGbsJxnxior7tfACYZjIsge6HsD4hF1MwWN/2fR+DfW06/e8ccDVPEuCEY+cqBdKZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqkACeDp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqkACeDp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso1635ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jul 2024 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720716879; x=1721321679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3yqNDdzLTGhFlyxunbrxQB7ZpJhsygMdfg4hB+E/qsY=;
        b=FqkACeDpgDGPzWyXhpNP8S9VZ6LVRfjvQP2fALKRzLtBFq2a+p+LpX/lf8VFg2GaV7
         DVGDgJpSh5jh+6WtJxjKOHnlWra8Xwp2Mv63EZtCCbE+oIX9xoVcMnkbe+QZ4oX4Y8zK
         aPIiNwV7RFTFvp01de7fsIHVAPVVK3YNJW1Qixee/HoBvz+zmcQq94LTYwB7u2r995LX
         IpxpR8FXivDDLlUwknM2h44qEgVpUwVEaw0bo43brJjrkDPvvCUrE3bbFhS04M2pHIDQ
         gAvYx140dfOClDHD1C740Ls1byULYBbQJ1SSkmdSO3GLXaHdejAhvN/C/UZ08B9hnits
         W1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716879; x=1721321679;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yqNDdzLTGhFlyxunbrxQB7ZpJhsygMdfg4hB+E/qsY=;
        b=BUk5qckRYJ9MTvAfOtaVIvTnUT6tdTAQCUiwLnAgeVf5/sLryaz2NByywHP6y68XDO
         /yHFUFE5VUfJ/lIBOQEFXKdlaA1S7fqnaaHgGf7Scue7wyA8R8mTKsfN7c+lciz4myuF
         lcigtocq5n3DuxN4IVmBLKja1wBkECEpOeW0WlHVUYPw51Ku3+OG9nfL+7vRMZK6j4ji
         Zq62jR5iNY0P7RzLuL8VEsoJUhbiFY+6vnHie956zZFMyx+TevrI4lbomxzRYxb7htxb
         0oIsE6SBZznWaouWezrLs6oyM40OPW7tKoYMm5/Qc1rTTJfTKuQYG07vbWqGPjQPcbRB
         1KdQ==
X-Gm-Message-State: AOJu0YyoMC+twjrCK8uRogk6F+7R+Hq12U782lt5WNhuir2jnze5aKoL
	JVJ2dth7Cl2NvYduw/G7cT7IHsbt1dPvyM4O+0SSouIObn7Q1z0gza/QxBHiOxrG7/gKANEajSC
	HpPtMUq9HaOGG0YdMw8RdQfk9vu/4xE7K9Fnm9/QOuBUCIJSKy8MI+xg=
X-Google-Smtp-Source: AGHT+IFUm54Av27ayS0tc6q143Eg64C/OYpgGZJmOlN9Oe9HvK2XAalroyyil4+0i7DLuWrHDPsJEUWcPXdgumf4pz8=
X-Received: by 2002:a17:903:1301:b0:1fa:7dc:d324 with SMTP id
 d9443c01a7336-1fbdcc89a3dmr3499895ad.2.1720716878784; Thu, 11 Jul 2024
 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 09:54:27 -0700
Message-ID: <CAP-5=fV+i3cuCWOrAw9sxYW7WSb47joWFpa3K3Eqw1MpLkqNfw@mail.gmail.com>
Subject: Linux Plumbers Tracing/Perf events Microconference - abstract
 deadline tomorrow
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

There will be microconference at LPC on tracing and perf events:
https://lpc.events/event/18/abstracts/1778/

Potential topics include:
 - Feedback about the tracing/perf subsystems overall (e.g. how can
people help the maintainers).
 - Reboot persistent in-memory tracing buffers, this would make ftrace
a very powerful debugging and performance analysis tool for kexec and
could also be used for post crash debugging.
 - Dynamic change of ftrace events to improve symbolic printing.
 - Userspace instrumentation (libside), including discussion of its
impacts on the User events ABI.
 - Collect state dump events from kernel drivers (e.g. dump wifi
interfaces configuration at a given point in time through trace
buffers).
 - Current work implementing performance monitoring in the kernel,
 - User land profiling and analysis tools using the perf event API,
 - Improving the kernel perf event and PMU APIs,
 - Interaction between perf events and subsystems like cgroups, kvm,
drm, bpf, etc.,
 - Improving the perf tool and its interfaces in particular w.r.t. to
scalability of the tool,
 - Implementation of new perf features and tools using eBPF, like the
ones in tools/perf/util/bpf_skel/.
 - Further use of type information to augment the perf tools,
 - Novel uses of perf events for debugging and correctness,
 - New challenges in performance monitoring for the Linux kernel,
 - Regression testing/CI integration for the perf kernel
infrastructure and tools,
 - Improving documentation,
 - Security aspects of using tracing/perf tools,

Abstract submissions happen through the website (you don't need a full
presentation):
https://lpc.events/event/18/abstracts/#submit-abstract

With the deadline being tomorrow July 12th.

Thanks,
Ian
