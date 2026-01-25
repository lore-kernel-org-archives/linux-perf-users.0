Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEB98405C
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Jan 2026 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371732; cv=none; b=bBq5lF1kycOBuHRtq780LjY1oXgIbOff1JzVFr9i7fct2ZHj9XdAc9g0BaGkw6683bj0HzsOd8K4912o0CrVcyGxXyebkL/cGHe5mrV4hPvyzwr9qrnO8vbFs1beXOcQzD3V8hYuiqKjpTGNXF3Y45ydduDRd8Wou+EX9x15P88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371732; c=relaxed/simple;
	bh=LbX1bJCVXzsmZIhljuGwQkBMgP+AErEY5RawD55Offc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIZBeh/lA7YY3JADoLuYTEFyc8jSK4YuNZq9cJpBGr/Ph50Q7OMxTxIpVj9qdpl2h63uOh1a+ESDv92pZuALbVDG1u5HJ1JGF0eO3WUvmUI8FPaS+lQc+l+i0gJL0R7gHrQWQxg8J1ZKudGvBMlyvnKC2+rfb9opbREX5siFEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGW2WHPq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGW2WHPq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so2278375f8f.3
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Jan 2026 12:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371730; x=1769976530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8e4SJevGIwtqo4T1xXLLi2W63QvJLEESxStogimHtY=;
        b=OGW2WHPqZm5OfQDizmYbMZBEZj6DoB8j+ZLroj7yGZCCKuo4qvgverO52TTzgockDC
         w/Djz9b8BOv7d6RXbQQZh4t54J5tWW/YQzZYkhUkdADTKJZyhKqP2he3YZDVZTiRNlmD
         wETjjPluqET7SuxzVtnxV2Cny6wAoMwJrzDvCRb+xoL920gZ9L/8DNYyCRM2D18CjL0h
         i9UASKeuPkBKIKzLviXja63Vuad97Zyi3/u4x9IpvR+A9sSZDlMjKhB0qrFoyY4TTjI4
         0BC4CZcm6EZrgpNhWjdGSGA7nQmf/R7swyA8e1+b598kWFTH5LDppBmGWiGyciGQefsQ
         dLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371730; x=1769976530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8e4SJevGIwtqo4T1xXLLi2W63QvJLEESxStogimHtY=;
        b=E5hBOmYAHsaYoZnFe5jQZY69rwPgaI+7NKTQ1QcygMzyXKq1TvMwgKufZHTIWvxnF6
         JkJyZhq61pypx6a8zQQpeHpICa8iOukUP5yb7z3tmsXhwoRoe0C49bc9PpIBadeUQF2B
         60xTQ1OmS3TYtoPLDPN37KcJrabH4NLMUJT75PZZh816KQHKH7xH3CDxRofXoc8ayRPS
         dfDptgODSCbG55A4AFovzZ2rqLrgQrH+b1J07kW0FsL2xi7IGoBrxAu3lwJNQiZbBWgJ
         OTjaJNtSFqYZIGFnWstTCS2nZLaRIrg/buwispIzBXKvGFFHfeRyIvutjBei7rT6PUTi
         0zvA==
X-Forwarded-Encrypted: i=1; AJvYcCUgWshv966azrLvxdCEoNsA+Fc/LoFKMdKWeaBDN71ZDCN1uIQnY6AS7W1Q5lcThKQZ5WNHppef6H0+hmXJorZx@vger.kernel.org
X-Gm-Message-State: AOJu0YxSk0wxztOul7SRf9W6LuDdU0YWPZ8n83vyzFQQfJ9DQAGOmfV4
	01RrNgVIDbd9x7fKz4+yqY1nd5CRPhwGs78hwoCgN0/l43PlkOgRjO/L
X-Gm-Gg: AZuq6aIUzb0qwNbU5UlqTRaUnrRRv1eo4vu85LarFFseo+47oBRQiazihZ7ociCvLmz
	wrkf7bettBzVwkdJW6i1rqC7yDOug8/t+xe+CVB3maz+ZbCHM9ld+g2CZiJJiqiACdg34fdR+UF
	vsDF4uNG5emiPKQDQ+vw+dy6vjVdjjhbP4+50vhxtAojQsJyBUWfjXCkopSvVaa7KcwGHZiVMax
	sxtz83oJCHEmA0bG70/fdpv5B4BS2hegCQ90lo+ydZQh+QVlRy9L5g+qVYkA+IM9aZYKv+OUjLM
	1wliyz8nDciCGb474/DaS/N8cX3Mc6P5p0mBw5sQaP9EhYs7shlPn4UB/4FETW+j8TFeyu80Tnv
	9XFmD0q8VkBM5d45JoxOQTkvQi5f792KEVwi2yb9MswrzIDfmem7DO8uWJPL3Goto6KXOjuJ8pm
	Kdj4VYg//W1t82h4+udfNHjFm0TafyHal7gCxmF+DlrxU=
X-Received: by 2002:a05:6000:2312:b0:435:af2d:2e05 with SMTP id ffacd0b85a97d-435ca39bd12mr4165832f8f.51.1769371729397;
        Sun, 25 Jan 2026 12:08:49 -0800 (PST)
Received: from optiplex (p548853b2.dip0.t-ipconnect.de. [84.136.83.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm23082976f8f.38.2026.01.25.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:08:48 -0800 (PST)
From: Hrishikesh Suresh <hrishikesh123s@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Blake Jones <blakejones@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf session: print all machines in session dump
Date: Sun, 25 Jan 2026 21:06:52 +0100
Message-ID: <20260125200759.57816-1-hrishikesh123s@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_session__fprintf() prints only host. This has been changed to print
details of host and all guests, by traversing through the RB-Tree. These
are visible when using high verbosity (-vvvv) in KVM environments, during
perf report dumps.

Testing -
- Test 1: Record the local machine and guest VM using 'perf kvm record' and
generate the report using 'perf kvm report -vvvv -D'. The dump should show
the threads and other details related to local and guest machine.
    - 1 Ubuntu VM running on Fedora host
    - VM is running a noisy program =>
	$ dd if=/dev/urandom of=/dev/null
    - On host run =>
	$ sudo ./perf kvm --guestvmlinux=/tmp/shared/guest_vmlinux \
                        --guestkallsyms=/tmp/shared/guest_kallsyms \
                        --guestmodules=/tmp/shared/guest_modules \
                        record -a -g -o perf.data.guest
      and exit after a few seconds.
      [ perf record: Woken up 9 times to write data ]
      [ perf record: Captured and wrote 3.150 MB perf.data.guest \
	(29311 samples) ]
    - Generate dump =>
	$ sudo ./perf kvm --guestkallsyms /tmp/shared/guest_kallsyms \
                        report -vvvv -D -i perf.data.guest > output.txt
    - Check for threads associated with guest machine.
      $ grep "Thread 0" output.txt
      Thread 0 swapper
      Thread 0 [guest/0]
    PASS

- Test 2: Record the local machine and guest VM using 'perf kvm record' and
generate the report using 'perf kvm report'. The functions running on
guest VM should be seen in the report.
    - Same setup as Test 1 but the test looks at the performance profile,
      to check if the function names are visible.
    - Peek into profile using =>
	$ sudo ./perf kvm  --guestkallsyms /tmp/shared/guest_kallsyms \
                                    report -i perf.data.guest
    - Samples: 29K of event 'cycles', Event count (approx.): 28711693142
Children   Self  Command  Shared Object            Symbol
35.69%   35.69%  :5820    [guest.kernel.kallsyms]  [g] chacha_permute
11.56%   11.56%  :5820    [guest.kernel.kallsyms]  [g] entry_SYSRETQ_unsXXX
11.12%   11.12%  :5820    [guest.kernel.kallsyms]  [g] syscall_return_viXXX
 7.36%    7.36%  :5820    [guest.kernel.kallsyms]  [g] entry_SYSCALL_64_XXX
 6.07%    6.07%  :5820    [guest.kernel.kallsyms]  [g] chacha_block_generic
 5.40%    5.40%  :5820    [guest.kernel.kallsyms]  [g] _copy_to_iter
 ....
    PASS

- Test 3: Record the local and 2 guest VMs using 'perf kvm record' and
generate the report using 'perf kvm report -vvvv -D'. The dump should show
the threads and other details related to local and guest machines.
    - 1 Ubuntu and 1 Alpine VMs running on Fedora host.
    - Find PIDs of qemu instances and use them during record and report
	$ pgrep qemu
        5816
        25098
    - Record the activity =>
	$ sudo ./perf kvm record -p 5816,25098 -a -g -o perf.data.guests
        Warning:
        PID/TID switch overriding SYSTEM
        [ perf record: Woken up 325927 times to write data ]
        [ perf record: Captured and wrote 3.692 MB perf.data.guests \
	  (57389 samples) ]
    - Generate dump =>
	$ sudo ./perf kvm report -vvvv -D -i perf.data.guests > output.txt
    - Check if the threads related to the local machine and guest VMs
      are present =>
	$ grep "Thread 0" output.txt
        Thread 0 swapper
        Thread 0 [guest/0]
      NOTE: Threads from Ubuntu and Alpine VMs are bundled together and
      appear as one guest machine.
      Looking into output.txt =>
	Threads: 6
	Thread 0 [guest/0]
	Thread 5816 :5816
	Thread 25098 :25098
	Thread 5819 :5819
	Thread 5820 :5820
	Thread 25103 :25103
      To conclude, information is collected for both VMs and not listed
      as two different guest machines.
    PASS

- Test 4: Check if any guest-related information is printed in
perf annotate. This test is included because the command calls
perf_session__fprintf() in its code path when using -vvvv option.
This could be explained by inability / lack of options for 'perf annotate'
to look into guest VM from host machine, due to no option to specify the
guest's kallsyms or modules. A similar explanation for 'perf mem' could
be used, as perf_session__fprintf() is also present in its code path.
    - Run annotate =>
	$ sudo ./perf annotate -i perf.data.guest -vvvv  > output.txt
    - Check for threads from local machine or guest VM =>
	$ grep "Thread 0" output.txt
        Thread 0 swapper

        Threads from local machine are found while threads from guest VM
	are not found. It is possibly because of a lack of a guest kallsyms
	option for DSO matching in perf annotate.
    PASS

- Test 5: Run kvm test available on perf path
    - $ sudo ./perf test kvm
        89: perf kvm tests                                            : Ok
    PASS

Signed-off-by: Hrishikesh Suresh <hrishikesh123s@gmail.com>
---
 tools/perf/util/session.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4236503c8f6c..6c6dfeb4eb33 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2674,11 +2674,15 @@ size_t perf_session__fprintf_nr_events(struct perf_session *session, FILE *fp)
 
 size_t perf_session__fprintf(struct perf_session *session, FILE *fp)
 {
-	/*
-	 * FIXME: Here we have to actually print all the machines in this
-	 * session, not just the host...
-	 */
-	return machine__fprintf(&session->machines.host, fp);
+	struct rb_node *nd;
+	struct machine *pos;
+	size_t ret = machine__fprintf(&session->machines.host, fp);
+
+	for (nd = rb_first_cached(&session->machines.guests); nd; nd = rb_next(nd)) {
+		pos = rb_entry(nd, struct machine, rb_node);
+		ret += machine__fprintf(pos, fp);
+	}
+	return ret;
 }
 
 void perf_session__dump_kmaps(struct perf_session *session)
-- 
2.52.0

