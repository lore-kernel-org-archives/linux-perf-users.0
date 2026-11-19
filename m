Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082922;
	b=E/AB8CU5e1/M1Mwtnur8ufIcXkg9Vdyv98flNUrxl4ZzAvlpUryLDaU/K/2JCn27ih8P
	 ZWUyss4dEvC4f9TySsXqfNtzSNuT5KfAYb/KAlAxupb6UP6YpYbbOM6Ki7xg0lYyEoqiP
	 rCWDr6G9egy5mx2rBz1LjExsSgKocjXh6ToO9t1c0oumewpH44aDeTbL5cPZe1Vjxf/F7
	 8eCaCwPm86I/2+fFYteeDsKocqQaWnMfc5sF5EhhEvLTEh8p3+q5nw4jAVnIUt2FFtgXZ
	 7c1f++ZzTlcQH0fEPPZkn+RWQ59hC6ewJwqJjLazLugDO+xkFILLaSQn8o1j0f5UY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=43hk92dqRNgt3cJF1KJekR7Qr7mj7rm5DTPnHeQ1LlA=;
	b=vVno6MxQUKcSie2R49cshf4I/AUj+mV0NPFevtYM4wGQbB2ljeZcHKFDgIPg7e7eZ8Pa
	 iLVCbOvjGLtxEp99+2lL1/Fv1V1AGhuCvKZWrLtV7WfY+qdsWeiJIRQroQx2GM//3pM9L
	 O3iXhyvsYBiTknFZmxD2HLmuJbg0S3JcMfPg79ZsKox3ErFrI6wf31X+QJqFuy3C7FX1k
	 ZERHcnEOGtviBlH6z6NXNKPysecDfUM1Zk52+aZ8BqN2KqlAPzZ3LRgGS2pKSY18Q62Wy
	 vyOsNNNpzZwUMhdaa9s88XPL/k7mIonAO5hN6l9SiMpGZfKZ/Dg/JN5pzmP9cFlmWZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+2ToTwP;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06032606A324
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06032606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C+2ToTwP
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2af4c8d00so4170252c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 02:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795082921; x=1795687721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43hk92dqRNgt3cJF1KJekR7Qr7mj7rm5DTPnHeQ1LlA=;
        b=C+2ToTwPlQU8PBN5Znee5RrKShji/ugJOPeVoPukgf5SnMN/CEMGTnGy9uBYVOmo2e
         LKWwgqQW8Wy7a9zvKqY0AOayH3bM9ZkYAx6sdWFKHmngT2z8vLNlYkuFUAUlDSUOwEW1
         qsSkB5ki0ufjSY9dp6IHtP2LT77JDA5/+srurvQAvCrZz4UkzbrYh//TvjPYyrjJNgzZ
         Z9JomJ/NwgtvOhD0BDGVEbM1xHCIskI9TeLJmWFtNDwjy022SLg2XkbW/nFe8H2Uvr6Q
         EyTHaJAMCZ876Pwysvf7v9MEsspHPryj04BPurtfZc/AxrNj7Ccj6JR6cZM20P1/yRLQ
         wd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795082921; x=1795687721;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43hk92dqRNgt3cJF1KJekR7Qr7mj7rm5DTPnHeQ1LlA=;
        b=RQ5J787QOUa3oBdv7tB8YK6/f20eyJmBgTYyhQUFgQlswr/ZvreA7K1m960RP+6z3/
         Slkb8B1QyzMe158ZgCzOIYdO3/K9Ss9iuHQtqkYqIaiJ50x/J1LzwVw3wrS6KP0qXYps
         Vwju+nxwnUUJhHa/mS2+mJBP/6aORHLcriH2QqK08nbDZ4ShAsrhxon4hwqtfkxru+29
         AMUpiHppjCLwXtZi3nwZLN5bajNh9TBxUkUVotKJrFI/1i59iHmk86P0RYkvk95VDHOk
         9WxIcjJPGzqDAlg5mhHunhlXcamzWy37amqFGsfNLV8L/MVCEvCU8qSRzvZbYTV4GGyP
         BO7w==
X-Forwarded-Encrypted: i=1; AL+hErH1JU5a6iTbUIWqSszSQief/EkgehPBgi8MyfczJy+PszGoFtXME1C7H+ZZVErJ14g22eSMJjVSFXtLebUbrl3f@vger.kernel.org
X-Gm-Message-State: APuU4Z/8BSEjTUAUN6V1UTIAibk3V3WqiUxHZJspJ7LM0UQmrED9ZnGi
	TnjXl0N9xHYFjqw/dPfCNl1PP3dWlh5FX4xnVVmdCn32X3lX/DErCy61
X-Gm-Gg: AYBFou3se7Tv/2uo90cHdoTyI6JLumcmzSTkIENdGAf+iZuA740d+nIEZ57Boqz45iR
	XRZlela7tP+qCyTqHvzXATEqqVejfUYGVXBZBY8XNRLDGlNgoHsApDhqDSXNDGXD64PP6nUTcSj
	W/ikFLGiv/IxXV8034EuPyWOJa3koEGredWHoAYb8Rq085lhzmDS2ObaCmBdwa/1ilO0l/gRl7x
	6657qFJvFgXpDmmaExJcdFUtyJbZ9WWeH8i3XqpkFlvRt3+hq4ttY5IYevQTRr77S5wdjIb1e5k
	svniRRNx2xMMuaX0ohSRWSzbp5wykQobK2mVetffed4W1CqgwZWh9WSDLS/jaPc+Tw0nPLlAbl1
	+IRmRDAZekqX+aWlrhJwO88thA5XamLf0d2JuAGhjpQcp5O/ZanX1xJ/AKrs3kkAcWDdh5v1YK/
	PfZpG9IGHk0u/UgUVSI60xxp0Wt/TZTq+s7CAGztT3+y+F1s6JdbJQHUxtorW9KxXuhPYU/+UGH
	O47q0Szp/8MicRfZPo55ld6h6iiVFSpmPlH/1oQZQZV0udlzE392r5ZdpVroUrncZKFI27ISP2J
	OUpVNGCLX4YOZYEFhD42fbrKNw==
X-Received: by 2002:a05:7022:e801:b0:1b2:4e2e:d95a with SMTP id a92af1059eb24-1b543c36946mr5087931c88.2.1795082920981;
        Thu, 19 Nov 2026 02:08:40 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4eafsm12843401c88.14.2026.11.19.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 02:08:40 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Hang Zhengyang <hang.zhengyang1010@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH v3] perf stat: Count kernel events in a group led by a tool event
Date: Thu, 19 Nov 2026 10:08:38 +0000
Message-ID: <179508291800.2785063.13205692423397372334@gmail.com>
In-Reply-To: <av6t6M0fUYdtXDEu@google.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com> <20261111110616.2249764-1-takano32@gmail.com> <av6t6M0fUYdtXDEu@google.com>
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

Hi Namhyung,

> I think it's better to make the first non-tool event as a leader

I agree, and I think that is where this ends up.  What stops me from
doing it in this patch is the group read: with a kernel event as the
leader, evsel__group_read_nr_members() still counts a tool event member,
while the kernel knows nothing about it (a tool event is not opened
through perf_event_open, it reads /proc/stat) and returns one entry
fewer.  evsel__process_group_data() then rejects the read with -EINVAL
and the kernel events of that group come out as <not counted> as well.
The smallest version of that is a few lines, but it changes what every
group with a tool event member prints, so it wants its own test and its
own commit rather than riding along with the EBADF fix.

> but I'm afraid it'd make evlist management complex

v3 leaves the group structure alone: no new evlist entry, nr_members
unchanged, and evsel->leader stays whoever it already was.  What changes
is how the members are opened:

  - get_group_fd(): with group_fd = -1 instead of the tool event's
    /proc/stat fd, or -2 when the leader failed to open, the same -2 the
    skipped-leader case already returns for a broken group;
  - create_perf_stat_counter(): a kernel event member is opened disabled,
    as a leader is, so that it starts with the workload, and
    PERF_FORMAT_GROUP is not requested for the members - read_format is
    per fd, and GROUP is what would send each member's read down the
    group path that only a leader can take.  PERF_FORMAT_ID goes with it:
    without a group read nothing demuxes ids.

The cost is real and the changelog states it: in -e '{user_time,a,b}',
a and b no longer share an on/off window.

Two things this does not change, both of which happen without the patch:
a tool event member still counts through a -D / --control window, and a
tool event leader under enable_on_exec is still not started by anything -
that is what "perf stat: Start tool events when enable_on_exec is used"
is for.

Either way the leader move is a separate series; I can post it once the
direction is settled.

Thanks,
TAKANO

