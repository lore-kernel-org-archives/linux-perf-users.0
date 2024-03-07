Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB67320E
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709788840; cv=none; b=Jmsp8qZ0s/QpJLqy0vFT6JpHaQZ7i6cSNdUxx851H57QluZpeEBFmT9uDymnCvQ+gr0F9RAi9KFP6cE61vvGQ4s/OXwBjKr2qqPWhg7G5zLCsA6yrtAVSF0kHk6MmkYaC6J6xtit9X6ydAhTrEHDDMQDBN/4DpMX5mo8WFgF5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709788840; c=relaxed/simple;
	bh=reJgXuWZvX9Km+Paa4xVhvcWJ0DeFLVwvc/JgsdYzww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gvW3nYX3A8MZ2zChNeTLV9Ux2YDyVz7DpsLfdC4GdmcCIUTwIWf84ItxXOHujfy+XFrT8lyk/qkjhMRhBIBjhWR3gTFxavJU8jSh+/c9wo9VHErWtylAQ1VsNB9g4/bCt8Kkoq2kHz2wkD0o3zJ2Mo3TNPk4DVhclKiOVvmsadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajR+YYzb; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajR+YYzb"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so505304a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Mar 2024 21:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709788836; x=1710393636; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=reJgXuWZvX9Km+Paa4xVhvcWJ0DeFLVwvc/JgsdYzww=;
        b=ajR+YYzbufWX04Px3TyR6cWoF4AxN2V8C74Wlvjfcnf5ojqzxAXJmn+NSb8nMuv9vr
         m318yLB2FMw0/LBjxsUy8eQO87qkCaGDiP4nQLnT99qQOBxJA9cfLi2EViAQSQOMXtvp
         7Rw4aCvlhsFoObkV4RLLqs+RsYwiapJtjbCoUiHfc/DSrOt4eZ9lzdad4qC3zjb6faxM
         1yLvLng002w0NeFPW9SY7i8VyaiYplpDSKQY45xl5I+y2DujP4UM7C5lHo7i1XQbjgrx
         CSuwnZ9VK+c6uxMl12H3cGs5AfubmgMbX4Rr0z3TffvaUkIYEnVgTPQXmxznR5hpeyPc
         rJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709788836; x=1710393636;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reJgXuWZvX9Km+Paa4xVhvcWJ0DeFLVwvc/JgsdYzww=;
        b=g4UhLHcVI4c9YeZR3og5AujXNt+9amvf6VyRTzYdn0nnPR9axRxs9uPKoXkRNeCZD2
         MTKaDF310v2U1cegrzX9E0IT8Yjp468I4co1MN6W2pajX3JnmWJbBVLaDsdFhqW4+UkR
         wtPXD0oHDDVrJVc/Hmgt87NgNzir1U3TCbB1U5Q9zS2bsNTunIGcnrqNxLXLCuturSgh
         OqOzYsfVf/PwjdmcZuVVBYTpP4kZDFlJgeie6lVutLRfTCA3TCCGQmYTU2ybZ/Icw/mN
         Do5Dctr9QqeD/kn4JmHjNOw9V+VdfGDZx+W5BP5Imotc2j3bZwlpghcwJ8rB9UpajyxR
         cFRA==
X-Gm-Message-State: AOJu0Yz+xN1pL7jDMd15Q8gDEv/r02qtt2uJozxWbq3gMxBiF3cVIhIm
	acJOcqNyaxpOo8ockj19ocDd7R0zJKMDycxMI3MgOlASnDvaARxHYD0xZAg9wUtSlvHkzBvQo1S
	1sQbgRy1VAJNRKmpSnkEKJUaUivTLJuJ0DOuBDg==
X-Google-Smtp-Source: AGHT+IGogCAN74f74Jq/IHyR8nGTlaYn3kjn4ObyclmHMZHpKz5ZwDViDpuI8sfwyV9rpkNXE9qEkXdhn1zmeh+2COk=
X-Received: by 2002:a50:c90d:0:b0:565:471b:c047 with SMTP id
 o13-20020a50c90d000000b00565471bc047mr12827101edh.0.1709788836400; Wed, 06
 Mar 2024 21:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M V V S Manoj Kumar <mvvsmanojkumar.mailinglist@gmail.com>
Date: Thu, 7 Mar 2024 10:50:25 +0530
Message-ID: <CAMZOccS0NcTSSHkJEiM6X5pM95OT98iwz152303qPnKdw49azA@mail.gmail.com>
Subject: Proposal for Roofline Support in perf
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My name is M V V S Manoj Kumar, an open-source contributor to GCC with
contributions to GCCRS [see
here](https://github.com/Rust-GCC/gccrs/issues?q=assignee%3Amvvsmk+is%3Aclosed)
and a research intern with the compilers group at IITH [website
link](https://compilers.cse.iith.ac.in/), India. I'm writing to
propose a project that aims to add roofline support to the perf tool.

During my internship, I've gained significant experience in roofline
analysis. This project involves incorporating micro-benchmarks to
generate roofline data, initially using the Original roofline model
outlined in the following paper:
[paper](https://people.eecs.berkeley.edu/~kubitron/cs252/handouts/papers/RooflineVyNoYellow.pdf).
We can later explore incorporating cache-aware rooflines
[paper](https://www.inesc-id.pt/ficheiros/publicacoes/9068.pdf).

For testing and comparison, I have access to a laptop with an Intel
10300H processor. This allows for comparison with tools like Intel
Advisor, Likwid, and other open source toolkits.

I believe your mentorship would be invaluable in guiding me through
this project. I'd like to explore the perf codebase to gain a better
understanding of its structure. I would be grateful for any advice you
may have regarding exploring the codebase, suggesting initial "easy
hacks" or beginner-friendly issues to contribute to, and pointing me
towards appropriate communication channels within the perf community.

Thank you for your time and consideration.

Sincerely,

M V V S Manoj Kumar
mailing-list email : mvvsmanojkumar.mailinglist@gmail.com
personal email : mvvsmanojkumar@gmail.com
official email : compiler.intern.24005@cse.iith.ac.in
