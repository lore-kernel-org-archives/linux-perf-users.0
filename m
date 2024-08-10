Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF9B5FEED;
	Sat, 10 Aug 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723266703; cv=none; b=Kac9JlAPXjDGkWYPwij5Vcit6QhnnqFjsdt5+R0x6jT9TKyoTecUtF2fyw8AIlyhb3VXfcLucGNEVjAp5sVeB/R31OqMN30CxXnqLvPOsAYri0rQyjz/Or2StfNt0R2ImcHqemZ04NxX9K1opIdvSvY7mEW4NCcuqq8OE/ri94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723266703; c=relaxed/simple;
	bh=L4ElqZyk+JQW9FVsGb1wPrxEJaIdxciAUewTWhpjnDg=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Utw9vzup2wC6lhcnNSm7dDT7WQdsm750Ij1nPWUqp2XF3XWUOThFYEGLCDWRngDExGueRy3aeyDOchtWtQb6iLFwS+poX7AWDv9hlSlDjVNzcnpxWy9oMS0KXT3B3BMywzQpCzwSFL8Xlpiqe9vVzVwLTL4WTUpC6UjTX7UJEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpGfX6DY; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpGfX6DY"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-260f033fda3so1769976fac.3;
        Fri, 09 Aug 2024 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723266700; x=1723871500; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SzA1wQsnjtSW4i/KXurPzijJ+9Ywyjr1A0XcEeoiZA=;
        b=MpGfX6DYtV5e01TcC+ui5JSEzUJV5QWR58dIMbDUmeSKaE4gOH+Yz98MwUI/+BVwax
         1h0Wty+WRG8smF2EE+W9ucsgrkJGXeRY0QQ+XuZuUxLYMpckLdgqCBzPo7/cHQIt9l8F
         mrPfbHqoq7MrgYcrZxkUVflFbAjmU1AmwsVgj/6BUNh5Hhu76eT1a3m636AbhZUc5t7v
         UixIfubP3qjqSrRL0nIHeOw7jjywrPRKeEq6mqrYmaF46C2MS2pOWyZOp2US0YzyjrGn
         OldgwwRWpkDdkn6DiZIj04IkeFK2xuet6xn8KDx5uSzCc3vLnkCITCrWJE1852hKLeyu
         Pycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723266700; x=1723871500;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7SzA1wQsnjtSW4i/KXurPzijJ+9Ywyjr1A0XcEeoiZA=;
        b=bVwR+DD5W8Q+QQ4y5iZpzhs1bD3CDRy9e9l39gFF7DhwOfxN6AdCQyOVJnvAFbSs/U
         L8UWIweM4LzANKtWeirmOWiawSlgnRtZij0ryKAR6QSqNYTOG23O/Dw99SsivZ1mw/3Y
         FKSoMk2HqPW6IZXO6PzLoCmOAimQ4qg68MSw34Z7Kn/KnudMqMBf1XCTJlTWgKTRcz/P
         R7F43w2NqP8lXDsmT/8IgmAegHfsE1HMClvD6UfFkj7ieUFAuJTGVWhXqAzTiso8tJ/s
         T3f/ObGiM5zOnSz3YS7RBVyTm+gs0SFdo04ozyENgi1GODD17UDF77IwjKS7AtcsViet
         3eOg==
X-Forwarded-Encrypted: i=1; AJvYcCXh/r/XWd9jQ+HN/mU+hBWSR93gB4lFQ+umU6Alvltqpyu5mYoAs+5hgmuSPcoEEq1tVNdtqYSpv4QvQxwVHDynrs0eo1HfjjO70HDh98AZxA==
X-Gm-Message-State: AOJu0Yy/xNhSxH85NE9FIP1i9gU0JvfuihkjckEY7UWPT4TgWMTZ4+kh
	qH/StFrF1YJl4rFR8q0ib69NjCWKGDtTtFKIApnfpPysHqC0HeDDHRIW3w==
X-Google-Smtp-Source: AGHT+IH6+MS8mS6SsSULxuY0iuIaJ1POFV9ihRtlyYHIQ2uqGGSXum5WMc1DaO4Os91a/KtGdeZVyw==
X-Received: by 2002:a05:6870:7195:b0:264:9161:82e9 with SMTP id 586e51a60fabf-26c62f92a90mr4873547fac.41.1723266700447;
        Fri, 09 Aug 2024 22:11:40 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac4184sm574950b3a.215.2024.08.09.22.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 22:11:40 -0700 (PDT)
Message-ID: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com>
Date: Sat, 10 Aug 2024 14:11:36 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: linux-doc@vger.kernel.org, Austin Kim <austindh.kim@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, Yeoreum Yun <ppbuk5246@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Subject: publish: perfwiki.github.io/main
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

I’ve migrated the content from

Link: https://perf.wiki.kernel.org/

to markdown format.

You can now access it here:

Link: https://perfwiki.github.io/main/

All the pages listed under have been migrated.
Link: https://perf.wiki.kernel.org/index.php?title=Special%3AAllPages&from=&to=&namespace=0

We haven’t been able to log in or sign up on

  perf.wiki.kernel.org

for several months now, despite it being a valuable resource for many
Linux users. I don’t know much about how the perf wiki is managed,
including any automated backups or the updates of man pages to the wiki.

Using the mkdocs framework, my knowledge of markdown, my keyboard,
and my efforts of finger, I’ve converted the MediaWiki format documentation
from perf.wiki.kernel.org into markdown.

I believe this was a worthwhile effort for me, especially
considering that it serves as a backup of the valuable content on
the perf wiki at this point in time.

Linus once said, "Talk is cheap. Show me the code." While I haven’t
been around for long, I understand that telling others what to do without
taking action oneself is not the best way to give feedback. When I looked
into it, the last edits, aside from the bot-built manual documents,
were made in May. Someone can check the recently changed pages, although
I found that it’s not easy to review the past change of history in MediaWiki.

I noticed from the perf mailing list that there were issues with
logging in, and it seems the door lock is still broken with no sign
of it being fixed. This motivated me to start this migration.

I wasn’t sure how long we’d have to wait to regain login access.
I hope you see this in a positive work and not as an act of rebellion
against using the original wiki. I genuinely believe this was the
best action I could take.

This situation also made me wonder: Is it really a good idea for a
wiki, which is linked to the kernel and serves as an official
reference, to be updated without review from others through the
mailing list?

While it might be convenient, during the migration,
I found quite a few documents that were linked for future additions
but never actually created.

With a review process through the
mailing list, I believe the documentation could have been more
systematically organized.

One thing we need to check is the licensing of the original wiki
content. The existing documents do not clearly specify their licenses.

If you find any discrepancies or issues with the migrated documents
compared to the originals, please let me know. While migrating, I
also fixed some errors in the original documents. If the original is
correct and the migrated document seems off, it’s likely due to a
mistake on my part—no AI was involved, just my fingers. Or perhaps I
was just tired. :)

I wasn’t sure if GitHub or GitLab was better, so for now, it’s
hosted on GitHub. I plan to mirror it on GitLab as well:

  perfwiki.gitlab.io/main/

The CI pipeline for building man pages still needs to be
implemented. I’ll work on that when I have time.

I’d appreciate any feedback and would love to hear any ideas for
improvement.

P.S. I also think it would be great if the markdown documents from
the perf wiki could be viewed offline in a TUI.


Warm regards,
Yunseong Kim
