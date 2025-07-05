Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109E17A2F8
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Jul 2025 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751727908; cv=none; b=M4B0C3TvBnpFLFZpNzSWSQcawWy7WSa9QtoYWAViz5pdGqbddkyl4vKLLBEXu9BY3y0Z7kHj9llVcuYsNViGJZ8gMM5dsocBVIZIOib/QfAQrInpjpZUIhox8rnvtHeOXdNz0ZbpZl+DVixFL6dojPvVNmNlnuoNeTZvLJIkhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751727908; c=relaxed/simple;
	bh=Z/WNbSB4Zhc6qrK9H8azETT8ypnvxYTbcNb2Bw/7Qz8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ah/+CRhB3VOgF/qpAYsBjHQ0OuZmdhcFGNQHLmkNeUpXWisBDepSfc9RcFN0fi3n1aVq7wb0o/q7Wq3zABtanPnP0AOOy7ws+VkQ2u6VNh4MFtnjR/HaqoZoPlzgHLq2wXXctVPiFnb7HzNkFfdyOHmaG9eFERqEsdgm7xvL1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df4189cd09so35322115ab.2
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Jul 2025 08:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751727905; x=1752332705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz48evUUHxXrLFQI+k2ltDvud9DuGBIERTJqmXvZ2nk=;
        b=peR/vhznfZIMabx0zZ/3J145fEQyQMvKzxuRgV6xcxkgz+sZe24wi2mlDWM7Qezaf3
         JOQT7878Us9p6zalYFmmyECah58khsNACDZA0ivNhLstH89E/W/pU/BeSRJwEJY4YccW
         ULqKqgAMH95aBvvFf7BW2hTWdoW9b6/AYXzrlTcnhIV5R5gEZ2l9Vxy5TB4uh/OQFO9D
         l/erJoTfXASvIVaqOvdTb9RODLRFbo6jUf08NmZb+fKkZLq1S3VOYSJv43TsedoL7gfI
         7kjL3p6mez2imxq1K0LonuPhrd7Ao1spTOS0oqwrLxlxfbrpBZEdkV6x8zVQaf/v9tTm
         niaA==
X-Forwarded-Encrypted: i=1; AJvYcCWmhpcYtBiPfcFZ/wmUsyrWoYkiU2eUsQigLe3AXVWDhL8geclQ+yhgiC8oFyfSg+dlNphN7mPu46LGSfknv+7h@vger.kernel.org
X-Gm-Message-State: AOJu0YzyORvs1/0vRTHd9TNHXli07f0PFGUp9FWPxnh+XjMrFPvKtDur
	0XgfLp1GItMA6tLYLBikWT39w5l6E+opatCCeD2kGmHaiOy98yyGuT6N/29Qy1W3+UF8dyVZatc
	4sQ2wZwiTtIJQQWNvAjHIWck0AB+Ik+i3guoI9pjLpBuRtEjucX1kP/SSEl4=
X-Google-Smtp-Source: AGHT+IFQnqDZn/WWQrFkk+UAForWQytNw0uOOFRemlzttbfP2vt83C7m6AEb7AF0H2D0D7PQG0YMlMWuVvAke37ILf45QsJ6gxWl
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5:b0:3de:14d4:a755 with SMTP id
 e9e14a558f8ab-3e137225181mr51249905ab.21.1751727905087; Sat, 05 Jul 2025
 08:05:05 -0700 (PDT)
Date: Sat, 05 Jul 2025 08:05:05 -0700
In-Reply-To: <f8dee957-d286-421d-976a-c0c580454fb3@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68693f21.a00a0220.c7b3.003e.GAE@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_pending_task
From: syzbot <syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com
Tested-by: syzbot+2fe61cb2a86066be6985@syzkaller.appspotmail.com

Tested on:

commit:         a79a588f Merge tag 'pm-6.16-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13691c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6dba31fc9bb876c
dashboard link: https://syzkaller.appspot.com/bug?extid=2fe61cb2a86066be6985
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157a2582580000

Note: testing is done by a robot and is best-effort only.
