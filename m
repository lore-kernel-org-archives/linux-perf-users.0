Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141C35A0E1
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707597; cv=none; b=WmSGciGT+yioRtwAMKl+YHm+rQrKF9HN/ZRiYXgKDkJbQLV2ZgXNYUD1CFYL6UfwOpavqnNyMefXT5ED99ZbUZcZJ12v1gfX72JWfzZ/AK6QS9f+SQJOEg3AF3OdGbJQ0X/EgzaIf71emDYoU2Beb1xvUyeVpOT+oZ35hpn1czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707597; c=relaxed/simple;
	bh=Cc6fPUEO/L/oLNhK5EswA4t+hLsVCBaH/yErJyfGUP8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qipOdtT9Cd5UdTruOPviTAQlTLj/HwIz/eKWoSNAtdP+p+HqlUMT1BjualMhPDE3i/FRB993UCkKZ1ytPcmJf6lWaK9sIKxEQJGmQoPxyiUWQG48JqJm0MAJXBJZrUicbQKVewZuH04c1z/wR5aC2AKH/qr7xaj05IYVhDT6Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dyw2wvCc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dyw2wvCc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d72043fa06so18595ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jan 2024 15:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705707595; x=1706312395; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cc6fPUEO/L/oLNhK5EswA4t+hLsVCBaH/yErJyfGUP8=;
        b=Dyw2wvCcDKMGByoIGzMnrCQK96MHPBlb1rzycHJpD9YoF1mTgrqjyVXfveUmXk7gDg
         Qc3zWqC3sVt9NKz8CHJ9dszpmG1wqkn+jj9YWV6JrAmefwZdQNLE4UttBudyRyhAL6vS
         8brMGkX4yBpKJezfZUmqt6jnmxEla4LX3nWZuQNdPhZZ6xtuk7VV9jDVMoiGqppmRVZJ
         js9Q7QAYq8u2noFZSxI3ABqHBOTqy9QvI7IjBoWBM90G+WPtcHqzM9V4W+0YPSA8cv1d
         9qCxhXa7qLEj/24sb0t3MG9MSHU13wNQRm4hpuo4F4jP38M8OEdevIsxiqctmsWkrnP1
         8weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705707595; x=1706312395;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cc6fPUEO/L/oLNhK5EswA4t+hLsVCBaH/yErJyfGUP8=;
        b=UKiIa6P12dMpZ5CxEDvic1uN6QeJBGsZ76Scn39IlAE1n9drDsuzg4kbf0WHwwh0h2
         FN3nz7DoGkBU7On9RpxkKKnvOZ6K0CfjISA+br+hA4JKTYSi5YljtxK0o5CzczOE1IOm
         bhw0vZw8+IU6xPoqOJkvLV3DkfedY85qJlANfUTLE4U3/V4f6ObERRty5hEiZmFdTBXu
         E0kLZWVIACdEC1WTLfAPVjmU3s4N/RWGIwgX1a2TzT30JprgIOLd5NoBdSW030fgxXaA
         H2HOXJqt1lMtxJSpObE09yiZ7OPJVy3Y0HaDa0bu+7irqQFgHk8RMpxC0Iqq4qwhodaU
         xU2g==
X-Gm-Message-State: AOJu0YzEfas5PU1tuLrh5B7rTe1ZqCkkjsEHIP3YQady3vCYGVOz/veb
	KgB2dOlYDvhPE8mBX6b/Kglg0dg9Kk+Vo93IPODPZDbWp+8CIOdWzNBHf6bysSZgjoQ=
X-Google-Smtp-Source: AGHT+IFHIk0NxLvuaH+T9N9vG7Khfg4f8EsAyyWUXerqkV0a5Cyj7iGn8eM36+yp1tCkq3soKsnNx/xuK/WQV3Rsmok=
X-Received: by 2002:a17:902:7612:b0:1d7:23fe:7a12 with SMTP id
 k18-20020a170902761200b001d723fe7a12mr7024pll.18.1705707594974; Fri, 19 Jan
 2024 15:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jan 2024 15:39:42 -0800
Message-ID: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
Subject: Issues with Linux perf tool on Raspberry Pi 5
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I thought I'd report the state of Linux perf tests on Raspberry Pi 5
and so I opened a bug because of the number of failures. I'm happy for
help resolving the issues. The bug is:
https://bugzilla.kernel.org/show_bug.cgi?id=218401

Thanks,
Ian
