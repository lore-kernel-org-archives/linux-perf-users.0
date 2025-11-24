Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05D015442C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009551; cv=none; b=LnG76vYLvTOHOv3jNHoiwJt94IGUNA7+MZImTPQijkC2C6sK6xHkFSSNEfNQtb8GRPDpOmQwREQQH4jnpfCcdVZcyH8FfgE1ig1Y8MUjjqnLV6fN3HQacZFUc/OOFaK4vZ0/qOts0tn2OUdivWqNbin2FkDV1cfeR+UeKsJ5/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009551; c=relaxed/simple;
	bh=z1wx3t5jKjEcNrhSgifx4UsAf8WEtDTjq11+jQqIv4U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mpNqtnDaDmALVjOdKe4XsqYFiuMKYDPJju8TZXyrBhEA3NLuIKSVvtg/IqIaYePoT9mhnMaZm93ms7w7E/JnvbvFnAqi/PvpHH1kV7aePQ77X52BdDfBxTRdTg7AXzUMFaLndRir8NK/2CtPR5/uyzhqL5ppYNVb9NAgTSZmP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=z0x5pLR6; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="z0x5pLR6"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-11b6bc976d6so5713774c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 10:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1764009548; x=1764614348; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1YZCVXiEkqh1wkAX0XsNqHRue7EcYYPrtfCYGzv/KL8=;
        b=z0x5pLR6kWot9ZTq5M0XyrAUlds/P/Oufv78iHxlTc6o20QUR8wOEs4gvnOQHwekIC
         Eb4rtaQgMP7rnJPNil13/jVVZ2hntrzHP2gPqN5DW715Tdl4KGMp81zbQH6P/o2ztQai
         YlZ6pYzbRTxbW8ZOtU+976RSi1IwV86dcNEaf4gG5nj3RplOyXi58Mrf6mLjMDFf7p8u
         3WI7HYrpnIdQqhWltEm9baBK6eCXiKQFRfo+ssn7wvtB+2aTA5QXoHlMAOIb3cLWWCYN
         NUj49J9p38zlaKmEPw+Quwrq4O2HbBf9G316YwgPgjvtNYvPCwy229Y+wsUreYFCKwe+
         dCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764009548; x=1764614348;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YZCVXiEkqh1wkAX0XsNqHRue7EcYYPrtfCYGzv/KL8=;
        b=iwjTRbobL2ADAcWxmwnYdAauzR2tR8EthoQEod7lzVbqk/pUrcP6Gl4in8aWHgPmR6
         JIg50ks57hFiWD9yMq7TY/YndUjUM5bfjNIxLvsPRxY6ard2M3keLIcre+knkmC14kz0
         59DJ0cWvGS3+psjtszBVhwDSpSZ0ObGA6cqLXnmRhgD4+gNNPz/+dfZkBBKQblaU33RB
         G3HGV9zsKPkrjVvv/EP6AZ6H/yrhSrKjJ5PYk/3QnkWYe6egd/IDX0SjQPjEwz70Oi0o
         Inx7ofRNUyWP+W2kz3bt5nYxxXu20a+r/0nkHhNPpJLL8Rff5OqS+I50vUVFpqDkDt1q
         p38w==
X-Gm-Message-State: AOJu0Yxje/t123AEhahSDHxbDZqzuRlIy8B6St2Rlnqe51NzkHZn2l0a
	pgfJ55soWhIpmyIus9yXlJbMIUcw5ozTtz4Api+SchCuOIe96jH5YO39Itd2hfVwPcDOCw5HuVO
	qgzqi5k/Kx9ackJIuGJVHekIZVVKVk7PJ1fdnZNj33TZZJbWSSH6CQEg=
X-Gm-Gg: ASbGncvkUEsQa2pcrSfFdA/28avqjgAKvEzjkHRZx2LLLvI3AGzQdIo/lqaggLcpmYW
	igjlF86FiMB4haiwylUmvoCVjhxuJP+CjZUycAnvfGzdm1eqHtpg148nGpimGgMfkrGhHd8lRUD
	OlSC26WEyYe/Ep3LF60pCS9sxF6e8oorzqqeoKDG+UexL7Gs34LplrzW43Ywabk60mXZDjRs2pi
	uoHwxf8OHGDMi+4TZIu8bQZmy9/632fozDGvFR7KClcrHAGXL5/+tyHNQBoRhaiXqMSPw==
X-Google-Smtp-Source: AGHT+IG3qo8acSnMAHs4F6HVtvZePxG9qQzvbLEdo8ZELZfLs75DplW1/Ao0Avf6hKvtCELsn/NCwGF/f7mT3vjgiWU=
X-Received: by 2002:a05:7022:258e:b0:119:e569:f86a with SMTP id
 a92af1059eb24-11c9c955bbdmr8472665c88.7.1764009547561; Mon, 24 Nov 2025
 10:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Shimin Guo <shimin.guo@skydio.com>
Date: Mon, 24 Nov 2025 10:38:56 -0800
X-Gm-Features: AWmQ_bnfESZeTEMjvhgLxFZvJdQ4eC63-5Edt7D4ke2moshuaqgOoVXHwYtfwUo
Message-ID: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
Subject: [BUG] perf: libdw not working for data collected on a different arch
 than host
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I see there have been patches aimed at enabling perf to unwind stacks
collected on a different arch than the host perf itself is running on,
for example, https://lore.kernel.org/all/20230606014559.21783-4-leo.yan@linaro.org/.

I believe there is still one issue that prevents me from doing
unwinding on arm64 stacks on a x86 host. As of v6.18-rc6, I still see
the following in tools/perf/util/unwind-libdw.c:

static const Dwfl_Thread_Callbacks callbacks = {
    .next_thread = next_thread,
    .memory_read = memory_read,
    .set_initial_registers = libdw__arch_set_initial_registers,
};

libdw__arch_set_initial_registers is defined for each architecture,
and the version is chosen at compile time, not for the arch the data
is collected on. After fixing this issue, I was able to get the call
chains. Is my analysis correct?

Best,
Shimin
