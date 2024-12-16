Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908EB29CA
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734332481; cv=none; b=kL16wjFS/n9GPxFiCMHMrbmreGbkU9I9WjHwqRRGZhL7RTmAykE6iRebUAbbeiCfeLklmFft5ClwHQMmDN0uZE5JZsQCvu+8xT/HjlXser4nHPFiAT/vLeKtBT+RHBFqcKK46XFR3f5w8KhIACxmu8T6q70MP9MJHQ8aYFWTcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734332481; c=relaxed/simple;
	bh=hglIw4WQQkQ6UfraRJ0awxZsRYv59kbTg7V3K6/BYcA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XUlwyJsLPqCvZ044ijWFRCFiJFDJK7Wz0bSF+s980MPBwd9NJVugCrGKvhgHcYcJwEs1ljDk6l/jDnsYQl+i9puDz0t6ucCjwGY5bm31X5IggdYs1GoH1zmVEM8jOdzTVANQ0s54dfbqBV/mJEVFCOancADWRtNk+34STIHPH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YBW7V1Z8vz9sT1;
	Mon, 16 Dec 2024 08:01:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DX70gW3hy4Nx; Mon, 16 Dec 2024 08:01:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YBW7V0nFRz9sT0;
	Mon, 16 Dec 2024 08:01:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 006788B764;
	Mon, 16 Dec 2024 08:01:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id B8sMBBpGhSDz; Mon, 16 Dec 2024 08:01:09 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D6EB88B763;
	Mon, 16 Dec 2024 08:01:09 +0100 (CET)
Message-ID: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
Date: Mon, 16 Dec 2024 08:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr-FR
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I noticed with 6.12 LTS Kernel that perf top and perf record/report 
don't display kernel symbols anymore, instead it displays the raw 
address with [unknown] as object.

After bisect I see that the problem appears with commit 659ad3492b91 
("perf maps: Switch from rbtree to lazily sorted array for addresses"). 
Previous commit 39d14c0dd650 ("Merge branch 'perf-tools' into 
perf-tools-next") doesn't exbibit the problem.

Now:

# Overhead  Command     Shared Object  Symbol 

# ........  ..........  ............. 
......................................
#
     80.49%  Coeur main  [unknown]      [k] 0xc005f0f8
      3.91%  Coeur main  gau            [.] engine_loop.constprop.0.isra.0
      1.72%  Coeur main  [unknown]      [k] 0xc005f11c
      1.09%  Coeur main  [unknown]      [k] 0xc01f82c8
      0.44%  Coeur main  libc.so.6      [.] epoll_wait
      0.38%  Coeur main  [unknown]      [k] 0xc0011718
      0.36%  Coeur main  [unknown]      [k] 0xc01f45c0
      0.22%  Coeur main  libc.so.6      [.] 
__GI___pthread_enable_asynccancel
      0.19%  Coeur main  libc.so.6      [.] 
__GI___pthread_disable_asynccancel
      0.19%  Coeur main  [unknown]      [k] 0xc0011170
      0.19%  Coeur main  [unknown]      [k] 0xc019ac64
      0.19%  Coeur main  [unknown]      [k] 0xc01f54bc
      0.16%  Coeur main  libc.so.6      [.] read

Before commit 659ad3492b91 ("perf maps: Switch from rbtree to lazily 
sorted array for addresses"):

# Overhead  Command     Shared Object      Symbol 

# ........  ..........  ................. 
......................................
#
     76.65%  Coeur main  [kernel.kallsyms]  [k] finish_task_switch.isra.0
      4.26%  Coeur main  gau                [.] 
engine_loop.constprop.0.isra.0
      3.69%  Coeur main  [kernel.kallsyms]  [k] do_epoll_wait
      2.00%  Coeur main  [kernel.kallsyms]  [k] timerfd_read_iter
      0.96%  Coeur main  [kernel.kallsyms]  [k] ep_start_scan
      0.87%  Coeur main  [kernel.kallsyms]  [k] __rseq_handle_notify_resume
      0.79%  Coeur main  [kernel.kallsyms]  [k] system_call_exception
      0.71%  Coeur main  [kernel.kallsyms]  [k] do_notify_resume
      0.66%  Coeur main  [kernel.kallsyms]  [k] timerfd_poll
      0.63%  Coeur main  [kernel.kallsyms]  [k] __copy_tofrom_user
      0.57%  Coeur main  libc.so.6          [.] read
      0.52%  Coeur main  [kernel.kallsyms]  [k] ep_item_poll.isra.0
      0.52%  Coeur main  [kernel.kallsyms]  [k] 
schedule_hrtimeout_range_clock
      0.49%  Coeur main  [kernel.kallsyms]  [k] ep_done_scan
      0.46%  Coeur main  [kernel.kallsyms]  [k] schedule
      0.46%  Coeur main  libc.so.6          [.] 
__GI___pthread_disable_asynccancel

Can you help fixing that ?

Christophe
