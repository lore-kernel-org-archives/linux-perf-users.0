Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F1929A312
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575804; cv=none; b=PxpztY23xSqgDREjg5I8M2V7CYcJChBSBipx+4mZcgFrNNXjxs7F2531Vz0AD41O+gmhPDJHI3pMlecRIIcDwkkmxfok6gqpdF7rtRv3M1d2uc3825te2nIgehuLhF1s9UpWS6iY8sWLqbihryQeskQqqjWq3df2Gv8u/Pekjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575804; c=relaxed/simple;
	bh=LjW6K2NGCL6j1mCxE3rLTN6SSayrAQcXGDlGaIHgT/8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kh8EvcMMFCvo4Gao3zUTS84nEtGrhZoD97gqk93gVp1DHL7K+MvyBo67H+yjz0KQg2Gogns/bZy6VTEboPhK8CSz1p5MrRbMXCavvesbMtzfI2cznr0oFMQJbp4tDQXgGNDqGupC6pGMVxuCmlKXh85dP9fLiozoL3/qj/0S9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-662c9283415so20217422eaf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 20:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769575802; x=1770180602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w89rCqd6Qvpdu1aZykFw+h/fa2z0CocuT9T82YXpSLQ=;
        b=JOwmuss+bOnbKmvq7JqrqattYXMlmXJ5+hrjLxM+yERFGgd04b0WFBVMMM/qVFhsv5
         RYTW+/pSnQi/geB3+Yvd3zp/ayceqN9ILlqxSrnV3qLIsuMHJ6fYv9iokwG/Dh/u6bW3
         BrbH4wN4e4IEDHVEceT5JKyKrd6uJ1bB/hP3XN/B/Y8wnwF/HccgxeYnPvJUNJcxjRN6
         9gfMQrXFr598jse/mqaOAzNHWItKtOgOniCuJMM4BcvmR6fOCih3Y0EbRs/hJlVOiqF/
         IOcq0kbQOZGA6IW2BXhLqDqY4b5pD8OXn0ru3vgwWqc8xN+H4Q66LmsnmeOuY29GpeZJ
         jcdg==
X-Forwarded-Encrypted: i=1; AJvYcCX/oMB3ZrmMzFrYptWZdodQRta+HUR1cGwriZSUd2imo25wwvVV363wdzHD1BRHHJERtVfhbekLUWVWnnePZ6EF@vger.kernel.org
X-Gm-Message-State: AOJu0Yypai7AGljiSQJr8pkHJFnzIAbFf6jmOf0PHEzg2CxzGdugCGX7
	c2V3tt7fctEQ0JuGnDqgDUlyAy1ZLzYs27raiaZW6fqE93Q/xb5CD0mENyTLtEEchWtB4sMVKH8
	nO5ePGqknAVRreNzcawKfS3e1sdBBLgIAA4vrfwiLrrdrzE4JeNcbQ+v+wKA=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168c:b0:65f:6601:b362 with SMTP id
 006d021491bc7-662f203d5a2mr2595263eaf.19.1769575802165; Tue, 27 Jan 2026
 20:50:02 -0800 (PST)
Date: Tue, 27 Jan 2026 20:50:02 -0800
In-Reply-To: <20260128035508.1840613-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6979957a.050a0220.c9109.0035.GAE@google.com>
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

commit:         1f97d9dc Merge tag 'vfio-v6.19-rc8' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170ba6ef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=151a39927f1e10b4
dashboard link: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b7718a580000

Note: testing is done by a robot and is best-effort only.
