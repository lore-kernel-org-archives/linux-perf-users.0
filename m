Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A43AEF24
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522504; cv=none; b=Vp+BsOe78GjH4n+ToJ9JcJHNL3T4ah/CYNPUmPnCMigRnV1u5XmuSOtFpkfwmlDWVe0OEatVoQc/sxaVC5Q+rb7ZE/9rVU+DCRAUowmHHoFubLKN22Ect9y5XEfW/Uep649mXSJpUgLcneu/QBCcWdQS/XtAybrvgfKcK/J4dYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522504; c=relaxed/simple;
	bh=1IZrA27vBWPsH9TyEvIMAEhdutCAtPosabk0WCXlXHw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WkXmGqmPW1HEsH+cNT5o67KLkWFDKV5VmXiEicX9+yu2NXeH6lnp+cdPgkxmtQ0nOWBG082IwbLDs2EGLHx5uFXH0uuoY6NVacv7g/hg0CKjl2ySZeVpW9308E0s5Uh0uCHXKNfkuBjb2jhvIGr8uD6keFfRonirEmWWpd6fp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-44aeefa1c36so296817fac.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 01:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522501; x=1787127301;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sje59A0L5pfuYt/lmCG6NQfH7lf5EC+6ZQFTCeyZXrY=;
        b=aOdUAna78uafaaNrfXDJKHLDhS7nwwQlPgzADvEA4iqoXCyO6Vckh/a6ewJspLNjRU
         ZXo1br00w8caxvf1N7f3Hzf1xs7DVFBXICjkBWyHVtQ/I/brAWsJ59WOXY021E2wJr1g
         mtvVmHEE+vNPQ9NrGM+FuuTiffJCu439qLITnSMpTwOtUZqwmlxnXPO6W+fluQVq7Ab6
         2096BbQEw4dCnie3C6KcSo0nSxoWYS0ms3qfb8/rrDwSBd7aaX9E0KgPjj4dMMWnKFWu
         4aaXoMgWJlwjY+dlnsMfLzUOimETqJce+z+LtCXHRrf4ywsU4amUNw878CIegenJu2Lt
         ZFXg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/3EiIdoBmZ+UNLBXWS0qkCsSslkP558eEHQzn8SForCDopkG9aot7lfwnAPoOcLDOZpiaNVyG4m6whdjX6yxr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrrqi7ABMlXBPouyiQLAwmzMpmsfmoFV+Py0YLchXrFo2VhBTI
	WB5QMhV9pz22UshJGjMbDXLgv76uh1aoVB1lmEALIP8mjpjOiKXHoI0OqqclnPkrqwWQ0Wv138o
	AulH6XcJBbyLFYd1U5PRzQCAEORNwj4bFvPOD+vawDJzq1MYV8H1d9QE5iv8=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:319b:b0:495:feaa:9e3b with SMTP id
 5614622812f47-4b2109c08ccmr2877535b6e.7.1786522501811; Wed, 12 Aug 2026
 01:15:01 -0700 (PDT)
Date: Wed, 12 Aug 2026 01:15:01 -0700
In-Reply-To: <20260812071231.201931-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7c2b85.d5f0ebe7.22d851.0009.GAE@google.com>
Subject: Re: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
From: syzbot <syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Tested-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com

Tested on:

commit:         f5bbbfec Merge tag 'probes-fixes-v7.2-rc7' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a47132580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d07fbc6821d72a61
dashboard link: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1604b479580000

Note: testing is done by a robot and is best-effort only.
