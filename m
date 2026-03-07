Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1D346777
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Mar 2026 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881701; cv=none; b=czeH9deyVd8EKcFu4ITWr2X4bXgfoXnTGZmYe5PcrYa7N2+d2daDQPdlKN9PSoRhyyw2gDf7C32T8TgdJ7x5Rz6DfdidKpQPSUrPaOwf454DeyoYXR55ODof1zMYkqf4iShrFc066lt9ltf4QB/6xYk47HF5xtJcj0YxleJoNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881701; c=relaxed/simple;
	bh=g+35zdjPPH7+f8/DnGBy5D0zYBWT5MUGuIxnnLIXxOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ov5XTPry4B4dW8/arAeG3vKY7t7tX6CS01enpVI2VdNZBA7H7w3coVvol2LR9x7hABzqmFeE4bnm9xc2UHiQ4k8YMScrIYXdqq3nuHYVbzpPgC3m/ER0NpxsmWz6ZlkE/aTcYbE3pbCCWWk8F+1hLlf5Q1jPX/FaQPQ+LyruurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 627B7LHq079209;
	Sat, 7 Mar 2026 20:07:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 627B7LE4079202
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Mar 2026 20:07:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7141c3e7-1818-4b3f-a017-4f8c8b00a90f@I-love.SAKURA.ne.jp>
Date: Sat, 7 Mar 2026 20:07:22 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [perf?] possible deadlock in refcount_dec_and_mutex_lock
 (2)
To: Haocheng Yu <yuhaocheng035@gmail.com>
References: <69abcb61.050a0220.13f275.0040.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com>,
        acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <69abcb61.050a0220.13f275.0040.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

Side effect of commit 77de62ad3de3 ("perf/core: Fix refcount bug and potential UAF in perf_mmap").

On 2026/03/07 15:53, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5ee8dbf54602 Merge tag 'fsverity-for-linus' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=101d5b5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
> dashboard link: https://syzkaller.appspot.com/bug?extid=196a82fd904572696b3c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b888ba580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f758d6580000
