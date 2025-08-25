Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2426D4EB
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Aug 2025 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756100646; cv=none; b=CjoFxbK+qwnJvCHGJCI2jk9I9HVsoTeTmkcJjtFZgAKz61xmn2v7DIMKxaN+DSSEr0SG7cyvZMnWcyXvGpnLVLTxXdgETr20OQxMTtjHHN6uOWpw4ryiAPO3GetN0lUIYNzOGtJhS6qSKNL2PXSfqAxfUQf/atdlcTK2Dga7b+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756100646; c=relaxed/simple;
	bh=I0MhP9f7dnL7COJfnTufg5YYZ9Elr3vP56QL7XCysUM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UEtWxgBWJj8s7YmtMdlAFH9fMbhlYTZo74qugF1Z6uOTN0Quwt1ToM16tUKacxmY5Ol4u1++AXVH4ASBq/GNQn3fqVZ5kbKajKgk/3WVWYQIvmhHCSZ9Pcq01gXOn4Jnhbkl4iYoGcMABLEwvpRRrEwT3YEfPZYqUmmiCETfoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAQVp6hD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAQVp6hD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756100643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ArQ1XD7lQrTyXjxiVaJcLedWY+cw60Vir2yFbupmOGo=;
	b=NAQVp6hD8gtmdRYsP2Zpd5u3W751As11znbiHrOf2YmPX/RKQp7twb3cgMmShcraUU8lg8
	STr92KGyp0oLN0MUktsSUtRwPqFUmigimi51y4y1cINJ6vZ3I8LU7D/L0kBrQRpd5W2r64
	xMIwomDzXjJxuTTqkxXCrQTdNukD7+U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-E2LeOM8sPzedCkfzHVT8GQ-1; Mon, 25 Aug 2025 01:44:01 -0400
X-MC-Unique: E2LeOM8sPzedCkfzHVT8GQ-1
X-Mimecast-MFC-AGG-ID: E2LeOM8sPzedCkfzHVT8GQ_1756100641
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-324fbd47789so3405853a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 24 Aug 2025 22:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756100640; x=1756705440;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArQ1XD7lQrTyXjxiVaJcLedWY+cw60Vir2yFbupmOGo=;
        b=JdMNn79rgPjga0cQNZMq5QOUQ2EhiPW46i4Cle+ixTzcsErxVBERkCDSd0+C64zcxQ
         txAgL6H6POKXrkFFJyyoHRcfnn6ccNaRl8VejyL5U07zWJCyhS/z0LVAFM+ExwrhcJGQ
         4mEiNYyzKUEFK5KiOFKkwWwRBInP7NcRR9lewZsRL5uLelAac7IH6o4e9nLjzI25xW1I
         p6rUjBhIrAns5qS8DOY1kpYzLnjz8vKmPbQA37Viq3wJK9+yAYYZO3KOLVDBe7DzHCcC
         o0HWi0rgZxguMUcSncYGJrTdMG7zJ4fXpNPX8Q6Ctd2qGws80PkWOpeqb9BBZcAUp5jB
         EzOw==
X-Gm-Message-State: AOJu0Yy+XnZ70Hhhj6tfG2L4K3mfVxKsTp6oxgs9MBYb8Q62pHFrK1mr
	TCWQK5Vemhh5QKlS2nvHmFaqJWlESElRL7mPczIgnIEQUsBVmmClKNzBxX4ECB85wioryAeyUzI
	+19dhB+09IWzH4SBFYZG0zkcNXfEryLf1+g7BldY083iInDBhEvvkTVkD1eg9+btXp661cFZz+V
	axAXHs6sChzykofm4QCwotywHimjIGg8BeOa8I0e6mMzTRXzBg+yW0JiEkMrc=
X-Gm-Gg: ASbGncu6gQvWjwag1U4yJurzTPEYxAThWFCf1p2MQtn8H6Tz7DfKZQLrW2NIGs9sWs9
	Ko2lex99zLMxGFfBQ8RhLBEApzNzlI7KEwvo8DDGP6QnWpNXcoSevkKjui6l8kkEgUY1EWk1U9s
	4bw7G1QOTMsDpGPK+cnqkbfg==
X-Received: by 2002:a17:90b:3d87:b0:311:ed2:b758 with SMTP id 98e67ed59e1d1-32515edd782mr11432015a91.3.1756100640442;
        Sun, 24 Aug 2025 22:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyouNXYw35emijI92qjiIgGkTlvloGBgPRN4PFMpoOIf3dt84qC1IvpQcaieoop4y1alkByLWYhqKWyAZCDxY=
X-Received: by 2002:a17:90b:3d87:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-32515edd782mr11431995a91.3.1756100640071; Sun, 24 Aug 2025
 22:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Qiao Zhao <qzhao@redhat.com>
Date: Mon, 25 Aug 2025 13:43:48 +0800
X-Gm-Features: Ac12FXw1u3CtLXfcCajj7TRAgg1AVLOIKCypv9wLIHKvovWeCJ8XsQxHNcdGUJM
Message-ID: <CAATMXfn-txra32FbKfOi6vutU0SeXBM0Jay=C0v5E+_8kLeHcw@mail.gmail.com>
Subject: [ISSUE] Question about perf test exit code behavior
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com, 
	Michael Petlan <mpetlan@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

I just noticed an issue when running perf self test. The command seems
to always return an exit code of 0 (PASS), even if the test result
shows FAILED. For example:
```
# perf test 108
108: perf all metrics test         : FAILED!
# echo $?
0
```
Kernel/perf version: linux-next tag: next-20250822

Is this the expected behavior by design, or could it be a bug in perf?
I would like to confirm whether the exit code should reflect the test
result (non-zero on failure), and if not, what the intended usage is.

Thanks in advance for your clarification.

Best regards,
Qiao

