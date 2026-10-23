Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772673;
	b=s0mpAUeH3jRltgcSvMrBA7fP0iVKQpfIF1r+/4usZVoKXKmWpAKRT9JEsLCYfcc7AR9I
	 wy5z5P5VbTtOmEd18PicCUaPKIXFqqGzZfYrnR5OUF2Xmn3PyXpq5/MpDvuSwdFvTyxw1
	 bXiXNd/iKnncVnR0+lFUNGVoTvf6C7h7I5thYMx8ciZrsGHaBqJDeIbztVQ2PE+g9YkfR
	 hc1BEHENaKuHz6hZEmJUp+2LlBJNR1u44K/6WL0PBKmGrbPv0pGH6CPb3OsTEFb/g3N/r
	 w1TZBa/v3lbuSuPApTMxdQxYd89N71uPNf98EOKD+jKVSdU0mHh0jMqsKsOKXs28LjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=ZVDqySEJ1BASNoDXFiyXutIunci5PTUDtCHQjzccD2o=;
	b=FzC5wAX0zr4KzuC+7m8RxnrwBgqc1xL5u5+hQUhGcuJdETnkDKVE0B8uVlgosMaxcAuo
	 0cOVte6w6b3iPMBGYU7SWxaZ3uMlUDQKHQP82Q9Nx/WJ7WHcuLNC0l6xb7GViJbYqbukz
	 7tZoNYigFQ2xuyOhMdhFucE5GBzUo0PYq0MO6hy+Uto8jwoWU5jAfNjt2EUImLjPIPj7A
	 fK2d8RlnAqIRexnt1olFW2giyW/0XG5WfsWJScw1Gb7Nx5yb2SXH8GUlLkUpDrpbKjh8f
	 G0dn45jMZcT0w/NLUaLG3gMlEe4Ix+bWyi4+aKyC6WbVEMklyzs03S76Y6hxbswNG7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NF9A5gaB;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1F606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 16:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NF9A5gaB
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so1616011eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772672; x=1793377472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZVDqySEJ1BASNoDXFiyXutIunci5PTUDtCHQjzccD2o=;
        b=NF9A5gaBzZHDU3lgZZ38vk6dgLoIdv2PoziJEE1Y70+iUlgtcZy4m8Z/td0XpCQmbZ
         P7Hkxmnh/3ngKItgVhZnAogFqBItAfzVA7OTASWLNGIbTziDMZUVDtMwup9bnuM0fBUx
         cFYESHmvtB3nRiQhZvjTkucM4q9kkDLMSje+U3PRfps91/Wf7da9+c8tRRi1yT3yOhJu
         KHX79Ek/Unkn90gZ6egUpG47v1fP7VKQ9RdPaxcwTKMkX7vc9yqKGYbrACO1kvQ+RGEA
         4QmVh+yXNteKmkJcOa+B20DacMa797Au/7rv/QYcKkkaKHXJO3BB0HrCgMcmf5YA9G2V
         0Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772672; x=1793377472;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVDqySEJ1BASNoDXFiyXutIunci5PTUDtCHQjzccD2o=;
        b=M5tyB9RKrNhzedocfDTg++FyX+BX6PTGm/kvMKpv6IJhRV96dE/Pagimcapcof/cN7
         0rKO9M2jEf37SlO0eTEqzn9vpb4/rPQH2ChZVIg8pnnun6fVmj0u40YPD2RYRJ65Wh2m
         IdNgimx6ZcA/hjn7vJVwHYAm5Id0K3mx7gg54Hovv4lhZmo0PmV6lrQix+l6gOC6Hgl9
         5hdpwjrTDPoDk98OkgF2bxaV36pF7GLEXDqUizs4UosIhwTEocZZTNKfM6C6Zxs1ge94
         30uX3OaDoGTSCrpwLruOJ1j2XGCegM/hwDFfx6yjPrieYBQwFd1jUY1gJaAvoBi8H8+o
         dy0w==
X-Gm-Message-State: AFq9FYIVF3MuypGnrFK6GAL1UTMXtC4dhfDHCF7FrgD36JrXB82uuov8
	LOp/GUptmtQggOwvZy/YfsaCg8fVQ5TqY2htu493imbok5SefbV38amSSVxe8Q==
X-Gm-Gg: AYBFou0Voy5pIPGYInGQ8cz0Q1M1XzJbgLZRgwqCIXjsRHpEWFAFq/ok6Wk2N+d4Xmc
	JHEVF6HbHJv2HqJAYnSG/lvZY5dC6l7BQVs5Xje+xyFpIQXcdYVXFP5TKBfZxqZy6QzeGFncxY3
	1itXDuLAOJlr9Qn6cSfmEmXUkorDvJIA2KwEjLPn1oZMrujRmEuMwCmkMhtro/1UM+4GyBGVEF2
	o3FjXdx1zS1vQ2/ysTFMagLJEJLBFZ21+IWa0Cy1u0SCuj1TRNUA7Wo+Nq1Rr3NJbP1v3hJHFA8
	0NpOKAoPhj6hvSv/ggMc6/8MMavw4QURJjq3iPt8es7j33eL1UHeXusvwbIsIowIvHDHOtfMU76
	PEc3EbnHm3Q0zZ7wjpG+nMdlC+lArk3ueDrZ3xME51NDAvvNNSURcgTckINC8L2eNysTx9PRagp
	W6rhNmSY9BVn7QDoTD1gRtjAvKnDxa6QI6z90QExu0yhWfi4FH7KPr2XM9Z3h1+qSHIlIk/a1xd
	tMs4MM8BMLIyIpaSfoFjzIhB5jhcDmYQfrQvIBWcK13bmfFCIT6tQniAGcUH4uQRF7BjQjzlw==
X-Received: by 2002:a05:7301:db82:b0:358:5bc0:4f08 with SMTP id 5a478bee46e88-369d98a64dcmr3384611eec.37.1792772671945;
        Fri, 23 Oct 2026 09:24:31 -0700 (PDT)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e6ec2d97sm631905eec.24.2026.10.23.09.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:24:30 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org
Cc: sashiko-reviews@lists.linux.dev, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking a group
Date: Fri, 23 Oct 2026 16:24:28 +0000
Message-ID: <179277266830.1885600.10381796857085073613@gmail.com>
In-Reply-To: <sashiko-outbox-182570@kernel.org>
References: <20261023085629.1694941-1-takano32@gmail.com> <sashiko-outbox-182570@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Thanks for the review.  The members are not unusable because of the
descriptor that get_group_fd() forwards; they fail to open for their own
reason, and the crash is in the enable path that walks them afterwards.

Instrumenting both steps:

  $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
  get_group_fd cycles:u   leader=user_time leader_fd=0x...  (the /proc fd)
  member cycles:u fd=(nil) supported=0

The leader is a userspace PMU event, so it opens without
perf_event_open().  The member does not open (on this box a system-wide
run is refused by perf_event_paranoid; on a permissive host it is the
EINVAL from the group descriptor), and either way it is marked
unsupported with core.fd released.

Returning -1 from get_group_fd() for a userspace PMU leader does not
change that outcome:

  with get_group_fd() returning -1 when the leader is a userspace PMU:
  $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
  Segmentation fault

What crashes is the enable path: evlist__enable() ->
evsel__enable_cpu() walks the members of the group and calls
perf_evsel__enable_cpu() on the member that never opened.  Skipping the
members without a descriptor, which is what this patch does in the four
loops, is what stops it:

  with this patch:
  $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
  rc=0  (cycles:u is printed as <not supported>)
  $ perf stat -a -e '{user_time,system_time}' -- sleep 0.05
  rc=0

So get_group_fd() is not the cause here.  Making the group descriptor
valid for such a leader would still leave the enable and disable paths
dereferencing a member that failed to open, so those loops have to
tolerate it regardless.

