Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340E78F24;
	Tue, 10 Dec 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825626; cv=none; b=bVVVlp53zc2PVb7wjnTxQnrLfN0YCG1JMUJbPBRIx73r7ijDYZBBoGKlPryh71Xyh5izmwDs+NKZGKKgzBHpRrYvQlMNopYmm3A9UTLnE00uzXT3kr7COIBrXfUihsPF5ajEo60csQzd+4wfgyYHmppw5dhOzehOXihLKUOpSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825626; c=relaxed/simple;
	bh=yUvWNxb4idOZ2cYkFtqd2fPWAQc5SwtEKIjpQd2PNA8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TSJIDe/nZq79KMIIEp61iL7i303Ny1ih5Ml1sEP2axdbonEj3qP6qON3xPmf32yzZgi3MDe4EAEuBy/XMab7o7CvvU7/2mq9FYlD0OBNEJvThTkh8XNUQHhg8bpyWcc43QPkhLoJ5wDee1JK/bOO9nMf5Er3Ptt8UGxCTqivrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKeHOKRK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKeHOKRK"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728e729562fso131884b3a.0;
        Tue, 10 Dec 2024 02:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733825624; x=1734430424; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUvWNxb4idOZ2cYkFtqd2fPWAQc5SwtEKIjpQd2PNA8=;
        b=WKeHOKRKGlNUSPOE4UIIA+jDmSGpcg0hfeX4KGnLW70Eqb5emQFhvhGoVL/npqqLfd
         gUC9zB01nW1tSYbdYzek9f7MnE1XeId+gvr8j6DdwENFrp7ULtpY8z6OOKmiFi9pKy/8
         QO76Q5tLSP3NNJbxl6LJ7k6gwAd33/3wQ+kkzLQDz3g/jL6paSZ2LjKgzRUE1jT8yce+
         1+2YS+kWJL5luEzl71+8d7edDYqcJwsqVOJaNyRgp9XUR7vH9OJ3WRbl25pdXgDSRca1
         PEqGvq7jmRKaXK1uSqCT9cn6V6iMdVUh+56byjVePDG8iE7TXhy0HzGj1LFhgN7JK07B
         xKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825624; x=1734430424;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUvWNxb4idOZ2cYkFtqd2fPWAQc5SwtEKIjpQd2PNA8=;
        b=bXyIJnddv3/oWyYpT/1754buh7pexcgLnoo1Dn1LDQbfZ7fju5SwCUD2QK41EH99UB
         5Ed5BXZmqUO/A8nexbCL2lkXHmD/SYNIZTxvQPyJxa4loSLstJPpeVIJznQqIL+wLGYw
         jtEsW98Qphs5xq3qdKVDeAlhdE+Myrk7OBXRZ9hRWesfs3aNXyQl45j9dqfsG+DSej2A
         1/J5df2VODjSmUNjxSgwVWDY9bjSmqacwcjbuX1ZQz9lnlnZKdRKItPRpSo+gX6XNWRj
         fHc/ZD+4zSEThHNUUA/rgYj1ooMZmjuZRpXA46b+BKMR5FlzP6RgICLnjNNo38g8QcV+
         jeAw==
X-Forwarded-Encrypted: i=1; AJvYcCWxBnN++pTiPGurdsMeBjmMYwz9vmWLHTbZ8S38BogeVcjUFJ7ABuQuvOsiOjsH2ZbXa+ljTMFumSD2lzqBArGyvw==@vger.kernel.org, AJvYcCX+3KSZBNDks5FhGjRmCWKKEZA+x8e0fgXRiR0+xeHB0yGPXqfWfavWxxHXHXESgglGFd+83A7wlIb4dd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRH1oz/7NyDSqiNOsiLQEYp7Xu614CJK534VK3rnq9nigr3SCF
	1EB6XN6wOCDXpg+8EjCZjLgYVTwRVEloNJkbjjhZVctMNoBMipDI
X-Gm-Gg: ASbGncuSCDzxI1nfsnh1018MZt0SztbDtyE2025zN0RhjVHOUwUb+v3e+5T34wUvluz
	Mly3kiuUCE07tE3kRWdn7R4uFjqeUdhdzFEXMYfOY9uNNcWlifTCyLIh6XjySCjYVGXC86EmAIN
	Rj6Jb0tmstY6lnXt1HPgonYzkAKoyLX2NnwRsm/yd9bdFnQz6JtM5R16EPuC/oxdcnVFnzooyjL
	FKGn7ZZDliMh3Xpy/aLZvLkZjFyKY+6qTz4a4yU7xrYf9uITS9HACQBkaSu/kqZhXD5GqC32JT4
	vvWceQe+HJ2MJ55CA1fph4tLj/9vWp7k/vgmSPamFw==
X-Google-Smtp-Source: AGHT+IEm9Hiq7FabfFpjZn/bDEYOqeD+ryLTLp+waiBObTFwwxsnEC+qurPI1TXeXrum62n36s/uhw==
X-Received: by 2002:a05:6a00:ae16:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-725db346d85mr15093285b3a.23.1733825623790;
        Tue, 10 Dec 2024 02:13:43 -0800 (PST)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e71ce821sm4200751b3a.183.2024.12.10.02.13.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:13:43 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH] perf evlist: Fix the warning logic about
 warn_user_request_cpu
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <fd2eedf8-0eb3-4dbd-8cdd-a6f87f7e3ffc@linaro.org>
Date: Tue, 10 Dec 2024 18:13:24 +0800
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Chen Yang <yangchen11@lixiang.com>,
 Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 adrian.hunter@intel.com,
 zhouchunhua@lixiang.com,
 linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 zangchunxin@lixiang.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5417261-B860-4993-AB33-A52AA2F2F83D@gmail.com>
References: <20240318121150.1552888-1-spring.cxz@gmail.com>
 <Z1cB28q8r54L59zU@x1> <fd2eedf8-0eb3-4dbd-8cdd-a6f87f7e3ffc@linaro.org>
To: James Clark <james.clark@linaro.org>
X-Mailer: Apple Mail (2.3731.700.6)



> On Dec 10, 2024, at 17:28, James Clark <james.clark@linaro.org> wrote:
>=20
> .

Hi James, Arnaldo

At that time, I also released a v2 version, and Ian Rogers provided some =
suggestions
for modifications. However, I'm very sorry that later, because I was =
busy with other
things, I forgot about this issue.=20
Now I'm very glad to hear that this problem has been fixed. I'll verify =
it in my environment
when I have time this weekend.

=
https://lore.kernel.org/lkml/20240319091429.2056555-1-spring.cxz@gmail.com=
/

Best wishes
Chunxin
