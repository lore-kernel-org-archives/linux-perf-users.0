Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A105910C3
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b7fb057153so8505595a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 04:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701260225; x=1701865025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vm0iiEEDW67QXAU5hmtno74YGdHPjqHpci2ImvBkZog=;
        b=DGvSGdV/r5WJJWmQSuY+XV8qu8AChcZ/bH5PNAbUnQLPEyEJ8AMqw9WsTSeEezr5cu
         HiEnY1QrWjN2bOf4o4G/gkgIh0fXvLq501QHb/VjyGCttf/BU+HcrCeiY7oM1g38ys6o
         cPUJdT2CvL7WSc1gBPJPuTViRBisMmeGzst2Wkv8F9b2c4Q3SM64sToiIA+0FvnMnyHC
         Ty4pec1yrRpYPsizZRF/i+Cp1VgF9XlfT3Qag0XyR3tpcaQDFYV+5TwOYdjzOH6wA+IQ
         hvOkx0dd6yRKZNfsMRsoShlIlXkacpoKvqtrM5cXA5veU0ToYRsUTIwrk6lHUAABoaQK
         rvHg==
X-Gm-Message-State: AOJu0Yxt6QWvULq6rFn6M52MHgdRwbgl8gAbgu4ROFXq48drRh/zc4Ou
	Zi0cjq9BG6AW4NDT9q8cNfgRuO5G21/DMh0Xb1nwBI5POGc/
X-Google-Smtp-Source: AGHT+IHm5egSj7drq/h6+tM2rakLRXVKiS/fewy4S6Rq3VCjTdYJQzjNbgFLIYLHh4HPavMnmoOq+9UCKki4IZlbNFEDmoS03isK
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:2b86:b0:27d:e40a:96d3 with SMTP id
 u6-20020a17090a2b8600b0027de40a96d3mr3758871pjd.2.1701260225232; Wed, 29 Nov
 2023 04:17:05 -0800 (PST)
Date: Wed, 29 Nov 2023 04:17:05 -0800
In-Reply-To: <000000000000d9483d060901f460@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006547d3060b498385@google.com>
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
From: syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org, irogers@google.com, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a71ef31485bb51b846e8db8b3a35e432cc15afb5
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Oct 24 09:42:21 2023 +0000

    perf/core: Fix potential NULL deref

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17172162e80000
start commit:   6808918343a8 net: bridge: fill in MODULE_DESCRIPTION()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=429fa76d04cf393c
dashboard link: https://syzkaller.appspot.com/bug?extid=756fe9affda890e892ae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12db572b680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10839a1b680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: perf/core: Fix potential NULL deref

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
