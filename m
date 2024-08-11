Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE4136352
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Aug 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382944; cv=none; b=UpcMVgSk4qBi7mhdHL4DpJsxtDchgAZMNQMvYlZbevSrXmMp8XMb6kMIR8D0MuGqXmfmqrtXNYPwxARRgLlYk9aaMIMGMiYNofQtK+7UNRuEjGyszY4cimPsI1FXQM/vB0OIGzogRhk4PIB+EsxyguPpETgVFel9I/vY4GOzyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382944; c=relaxed/simple;
	bh=4VIJuiITEW7ewzHq3AA+up117C46Xna41EtTB6jRDpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEkIy9Z/VpRSnJOFCwhT6s2TowL467SuW5FNdnmq6M1QVJ3rfRA6Sk8daGJJz74he+tk8w2SFr62O5xxU/OmjzIIWrrGegteNW/knxvQaX5LXgkOPKG+89YrdfBzTJpiG9Rqimmb06ZryH7mZ1ww/CnbPytZQN+RaNh2CEeOGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3f65b494so47899045ab.0
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Aug 2024 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382942; x=1723987742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnkKa50lZ8hs4Qk4BwOyGnKaIm3qqKKfma5Pq5XbRrs=;
        b=vVLU7B09yTA7chtjheyWoNcDAB554PWfHXnopLu5g3c5CNp2snqtfiMuc0lYWYOe0E
         e1GCRJZQfRbSTFBz87mzsIMwnXZvU9el4F2cjNC6D6ZYELDKP5FW3ugXTptaroeolcdg
         3n52Iya/fSGA9bWkNme24XiZcFzFpLWDEzACrulJglN+tf/VKFrsH7kJIXCIdTycdkiB
         4HdGVH8+QjFPrX9Xa1nBWBODGkmkE7sjO77/e9E/sGgAO0ypAeyWfkcfKFCbwdVsl/t/
         7xYS4RyMJccfYhdqLXW96Gup8x46DG8Tmf4+y5bc31fRPKKYWR7rsq/0YthEIlKu9ezu
         JG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKpL+ZrogyRSiy/kVPTidjqgShCXVgcizp3HwV9RkU6qoNInpT56T4J5+9a+cjCOIMr0vRyevGKemxj2Tt/hNRV+gavPfHXsKAi8Lcy4uFNA==
X-Gm-Message-State: AOJu0YzszF98w+B04NqIBZEgHfsicQDCFjxP9GFPNeoux+y5D82jmkKH
	g3btstPsmWgKeETTgY/j5txIEJf0oGD+CAFLjw898kSxU5tWAVIANTBtEDWEtRjPqhbS6dK7lJX
	+i56tQhmFJnThf956QXNWR1D9FmXmcalK165zEEG1ZdFvw/qJdUn0wGY=
X-Google-Smtp-Source: AGHT+IF86Mz5uFG6noEffyBuynmhir8KuMZ4KINCzCYEAYQ+fD0uNmCOh4N+xL+7PJ1qedIPxl2odenKYUfLMEUCn/VWv3Q+BIPQ
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:396:2d57:b1cb with SMTP id
 e9e14a558f8ab-39b748412dfmr4968815ab.0.1723382942031; Sun, 11 Aug 2024
 06:29:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 06:29:02 -0700
In-Reply-To: <20240811125816.GC30068@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000127956061f685c79@google.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
From: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrii@kernel.org, irogers@google.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com

Tested on:

commit:         6a0e3826 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1430267d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=f7a1c2c2711e4a780f19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1685014b980000

Note: testing is done by a robot and is best-effort only.
