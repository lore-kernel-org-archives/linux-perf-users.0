Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B41A4F12
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745463383; cv=none; b=owJ8qgdqPfx5e4A05aw9ca3uvuwyIg0X7n/Mvd/R6+QOtdmQanWjsbahEMSdliybVw+VIM0xGh/RZqRuHjwI9QcySbuQdMBBfBMTlhjv8Fez28c6ZLi6Un45Llr08O/7eGMAaPJCTdukfSOYGgOfDylJIsL3713RpJDp7OF4tMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745463383; c=relaxed/simple;
	bh=VokZQrmYwbUA6gnrEVK//m0k8hND7smhj9mn+ebaMWI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m9Le2tzr+HFHaV9WBh7Fh1HcjTWUCNEpey/eWluoAMCWl4+C8n2YzxBQVb+2K9jxUcQrXeBNBLASEN41RaeTyFO0hAidiPi5+Mo0s1E4jpdGCVfieqjw/8JWwxERj8JFu2H3QZqmhJuqy+UzkI6A09DPO2XEYOIxMhvv8KqD6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 53O2sVGQ063286;
	Thu, 24 Apr 2025 10:54:31 +0800 (+08)
	(envelope-from baisheng.gao@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4ZjgWd3CQcz2LkD14;
	Thu, 24 Apr 2025 10:53:01 +0800 (CST)
Received: from BJ15137PCW.spreadtrum.com (10.0.73.32) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 24 Apr 2025 10:54:29 +0800
From: Baisheng Gao <baisheng.gao@unisoc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>
CC: "open list:PERFORMANCE EVENTS SUBSYSTEM"
	<linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM"
	<linux-kernel@vger.kernel.org>,
        <cixi.geng@linux.dev>, <hao_hao.wang@unisoc.com>
Subject: [PATCH] perf/core: Handling the race between exit_mmap and perf sample
Date: Thu, 24 Apr 2025 10:54:29 +0800
Message-ID: <20250424025429.10942-1-baisheng.gao@unisoc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 53O2sVGQ063286

In order to fix the race condition between exit_mmap and
perf_output_sample below, forbidding to copy the user stack
of an exiting process.

 Internal error: synchronous external abort: ffffffff96000010 [#1]
  PREEMPT SMP
 CPU: 3 PID: 2651 Comm: binder:2649_1 Tainted: G        W  OE
  5.15.149-android13-8-00008-gbe074b05e5af-ab12096863 #1
 Hardware name: Spreadtrum UMS9230 1H10 SoC (DT)
 pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : __arch_copy_from_user+0x180/0x218
 lr : arch_perf_out_copy_user+0xb0/0x17c
 sp : ffffffc00801baf0
 x29: ffffffc00801baf0 x28: ffffffc00801bbf8 x27: ffffffc00801bbe8
 x26: 0000000000000000 x25: 0000000000001000 x24: 000000000000feb8
 x23: 00000000000005f0 x22: ffffff80613c8000 x21: ffffff8143102a10
 x20: 0000007c239643c0 x19: 00000000000005f0 x18: ffffffc00801d058
 x17: ffffffc16e677000 x16: ffffffc008018000 x15: 0000007c239643c0
 x14: 0000000000000002 x13: 0000000000000003 x12: ffffffc008000000
 x11: ffffff8000090000 x10: ffffffc008090000 x9 : 0000007fffffffff
 x8 : 0000007c239643c0 x7 : 000000000000feb8 x6 : ffffff8143102a10
 x5 : ffffff8143103000 x4 : 0000000000000000 x3 : ffffff8093cad140
 x2 : 0000000000000570 x1 : 0000007c239643c0 x0 : ffffff8143102a10
 Call trace:
  __arch_copy_from_user+0x180/0x218
  perf_output_sample+0x14e4/0x1904
  perf_event_output_forward+0x90/0x130
  __perf_event_overflow+0xc8/0x17c
  perf_swevent_hrtimer+0x124/0x290
  __run_hrtimer+0x134/0x4a0
  hrtimer_interrupt+0x2e4/0x560
  arch_timer_handler_phys+0x5c/0xa0
  handle_percpu_devid_irq+0xc0/0x374
  handle_domain_irq+0xd8/0x160
  gic_handle_irq.34215+0x58/0x26c
  call_on_irq_stack+0x3c/0x70
  do_interrupt_handler+0x44/0xa0
  el1_interrupt+0x34/0x64
  el1h_64_irq_handler+0x1c/0x2c
  el1h_64_irq+0x7c/0x80
  release_pages+0xac/0x9b4
  tlb_finish_mmu+0xb0/0x238
  exit_mmap+0x1b8/0x538
  __mmput+0x40/0x274
  mmput+0x40/0x134
  exit_mm+0x3bc/0x72c
  do_exit+0x294/0x1160
  do_group_exit+0xc8/0x174
  get_signal+0x830/0x95c
  do_signal+0x9c/0x2a8
  do_notify_resume+0x98/0x1ac
  el0_svc+0x5c/0x84
  el0t_64_sync_handler+0x88/0xec
  el0t_64_sync+0x1b8/0x1bc

Signed-off-by: Baisheng Gao <baisheng.gao@unisoc.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e93c19565914..9c9b571b812d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7867,7 +7867,8 @@ void perf_output_sample(struct perf_output_handle *ha=
ndle,
                }
        }

-       if (sample_type & PERF_SAMPLE_STACK_USER) {
+       if (sample_type & PERF_SAMPLE_STACK_USER &&
+                       !(current->flags & PF_EXITING)) {
                perf_output_sample_ustack(handle,
                                          data->stack_user_size,
                                          data->regs_user.regs);
--
2.34.1

________________________________
 This email (including its attachments) is intended only for the person or =
entity to which it is addressed and may contain information that is privile=
ged, confidential or otherwise protected from disclosure. Unauthorized use,=
 dissemination, distribution or copying of this email or the information he=
rein or taking any action in reliance on the contents of this email or the =
information herein, by anyone other than the intended recipient, or an empl=
oyee or agent responsible for delivering the message to the intended recipi=
ent, is strictly prohibited. If you are not the intended recipient, please =
do not read, copy, use or disclose any part of this e-mail to others. Pleas=
e notify the sender immediately and permanently delete this e-mail and any =
attachments if you received it in error. Internet communications cannot be =
guaranteed to be timely, secure, error-free or virus-free. The sender does =
not accept liability for any errors or omissions.
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=E6=
=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=BE=
=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=85=
=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=
=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=9D=
=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=A0=
=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=
=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=
=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=A8=
=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=E4=
=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=B8=
=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E6=
=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=A4=
=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=8A=
=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=E8=
=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=80=
=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=92=
=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=E6=
=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82
