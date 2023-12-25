Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6452F71
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Dec 2023 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fd902c677so39594925ab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Dec 2023 09:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703525467; x=1704130267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFqI58q7VNYJmMslCgc+pTUxt4F8ra7+YSzIXJuw1CI=;
        b=o3UpZa+joB9TXD3k+eP9RHwRk6nMmhmsD/Qd3vDdLoP7MjH/NiYI358GngDFCF5aH1
         QADfM9Ue2O5jGiywjBOluOr5S01iTGlKtOTx3twBOAO3Oi/u5o6jlCBpnvM39cZTmW1c
         jAaLBctUUI+62shhkYdzSDgzg2O72tYLeDDEMb5MaeUvef6E1mZjE+1V2WIeW/4yyJ6A
         paqmN/P5DJzuLkXuaNRyD8eWok4BWzQ09pPOuYOgC7W2V0+nFO2vru3Gj4V/1Pwjfuln
         9rZMjuEQgrYwQ4RhAKcS4bjASgD7cl8zCrQIiMawsvTc/F3QiuiwBbtEk+jvoLeuPDN4
         9wbA==
X-Gm-Message-State: AOJu0YwEwNfrQ2I2/qc3WRuK6xlNyILoHHlJjQKU6TafcKZd+19HwdU7
	mTsg6WOGDiQUfWO9/wgU6jIwBgA6o5zlqOWjQL+ttjEbWqbq
X-Google-Smtp-Source: AGHT+IG150p2eMqab1PfIi2zECmHDFBS0UnssC+uKVBgIAlE5EIKxdwzS9Wj1PI8eSGg+CAuQ8PyuEKXFEI4yjrkYGt1uF1mvnCE
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:35f:e976:3283 with SMTP id
 k3-20020a92c243000000b0035fe9763283mr613348ilo.2.1703525467494; Mon, 25 Dec
 2023 09:31:07 -0800 (PST)
Date: Mon, 25 Dec 2023 09:31:07 -0800
In-Reply-To: <000000000000e8099a060cee1003@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b23dc060d58ee7a@google.com>
Subject: Re: [syzbot] [perf?] WARNING in perf_event_open
From: syzbot <syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 382c27f4ed28f803b1f1473ac2d8db0afc795a1b
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Nov 29 14:24:52 2023 +0000

    perf: Fix perf_event_validate_size()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170e70cee80000
start commit:   5abde6246522 bpf: Avoid unnecessary use of comma operator ..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148e70cee80000
console output: https://syzkaller.appspot.com/x/log.txt?x=108e70cee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=07144c543a5c002c7305
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14857e81e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126ac36e80000

Reported-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
