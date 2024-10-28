Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6AE1EF0B7;
	Mon, 28 Oct 2024 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152487; cv=none; b=b8vL4oo5uUVT2zw6o+tX5c4AqWRmOFj77+mL3tfAA+dDkwnpeJisynanEKmj7m3QMea1xkChkd15g7ekdgnHM9lNOOMLEiJwSFYB47Kbj8/JjA9rYNEk0bkpLSq+RFA0ok3d0fRagIQ8Umt0kLC6KC5FiMhhL0B/UvTvsHO5XiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152487; c=relaxed/simple;
	bh=9qFj60xTGaX4eHnykcmFYHt4aiKtsIC4aRF5OFa4inw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr2HDnba0a6M5ZILHak3uB5OFeszpbF7xowTNdTl9XsGCeJnJdp4t14ne+RXztWA3Y/kDwxHqLGKNgQcgnBiwK4WbsnL90q7zIsjzjXcW1HfMB9Y7z6d/LFl8aDAiXn86DXtYJz3Q6XymTMpf3xKkPMfpFh/qHEN2l8kbzDr5s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyYwMdX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyYwMdX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFB3C4CEC3;
	Mon, 28 Oct 2024 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152487;
	bh=9qFj60xTGaX4eHnykcmFYHt4aiKtsIC4aRF5OFa4inw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oyYwMdX6XVgXCmJ4KNnt21POojSJilNoJZlcnsFSurciAQG3H+8/xgxTv0ByOyej0
	 ax+EvanAKjU/+PC7BbeF/7Gip5weNoaWhJHaaKPxAO5PzqwK2Zt04cTa28jUtWjlxD
	 bTgREwzqa/TDNIpN1eR+JotBh6su0X80y+DZczUOAAzGbXXF56JnO8WaR8xDDYFToh
	 DtRTPeuUEJqaC9KUPQosezQuosUK0A7Ar8PdXxBeHYQ5JXylJvwmw0G5LkTRyxZJnI
	 IzlkW28nIn8xfnHeyzBgr+ClLfjdoZy0K5ieQErGcnJSlM/Vk4c6LIzxJ/PldCIO0r
	 tcA2lBUj3MHGg==
Date: Mon, 28 Oct 2024 14:54:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 00/19] unwind, perf: sframe user space unwinding
Message-ID: <20241028215444.gd5hoc4v4f7u3otd@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kb4yfythcvd7z5d5"
Content-Disposition: inline
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>


--kb4yfythcvd7z5d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Oct 28, 2024 at 02:47:27PM -0700, Josh Poimboeuf wrote:
> It still needs some binutils and glibc patches

binutils+glibc patches attached.

-- 
Josh

--kb4yfythcvd7z5d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-binutils.patch"

From: Indu Bhagat <indu.bhagat@oracle.com>
Date: Fri, 25 Oct 2024 14:33:19 -0700
To: jpoimboe@kernel.org
Subject: [PATCH 1/3] ld: fix PR/32297
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

When _creating_ SFrame information for the linker created .plt.sec, the
code correctly checks for presence of .plt.sec.  When _writing_ the
SFrame section for the corresponding .plt.sec, however, the conditionals
were wrongly checking for splt.  This was causing an assertion at link
time.

This issue has been known to affect glibc build with SFrame enabled.

No testcase is added just yet.  A later commit ensures correct SFrame
stack trace information is created for .plt.got. A test case (where only
.plt and .plt.got are created) is added then.

PR/32297 sframe: bfd assertion with empty main on IBT enabled system

ChangeLog:
	PR/32297
	* bfd/elfxx-x86.c (_bfd_x86_elf_late_size_sections): Check for
	  plt_second member not for splt.
---
 bfd/elfxx-x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bfd/elfxx-x86.c b/bfd/elfxx-x86.c
index dd951b91f50..0d83ce57d4f 100644
--- a/bfd/elfxx-x86.c
+++ b/bfd/elfxx-x86.c
@@ -2680,8 +2680,8 @@ _bfd_x86_elf_late_size_sections (bfd *output_bfd,
 	_bfd_x86_elf_write_sframe_plt (output_bfd, info, SFRAME_PLT);
 
       if (htab->plt_second_sframe != NULL
-	  && htab->elf.splt != NULL
-	  && htab->elf.splt->size != 0
+	  && htab->plt_second != NULL
+	  && htab->plt_second->size != 0
 	  && htab->plt_second_sframe->contents == NULL)
 	_bfd_x86_elf_write_sframe_plt (output_bfd, info, SFRAME_PLT_SEC);
     }
-- 
2.43.0


--kb4yfythcvd7z5d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0002-binutils.patch"

From: Indu Bhagat <indu.bhagat@oracle.com>
Date: Fri, 25 Oct 2024 14:33:20 -0700
To: jpoimboe@kernel.org
Subject: [PATCH 2/3] ld: fix wrong SFrame info for lazy IBT PLT
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Fix PR/32296 sframe: wrong SFrame info for pltN and .plt.sec for -z ibtplt

The x86 psABI defines a 2-PLT scheme for IBT which uses .plt and
.plt.sec entries.  It was observed that SFrame information for .plt.sec
section was incorrect.  The erroneous assumption was that SFrame stack
trace information for .plt.sec with lazy binding is the same as SFrame
stack trace information for .plt with lazy binding.  This is corrected
now by initializing a new SFrame PLT helper object
elf_x86_64_sframe_ibt_plt for lazy PLT with IBT.

Add a testcase where linking with -z ibtplt generates .plt.sec entries and
ensure correct SFrame information for it.

ChangeLog:
	PR/32296
	* bfd/elf64-x86-64.c (elf_x86_64_sframe_ibt_pltn_fre2): New
	definition elf_x86_64_sframe_ibt_plt.  Use it in
	elf_x86_64_sframe_plt.
	(elf_x86_64_link_setup_gnu_properties): Lazy IBT PLT entries are
	different from lazy PLT.
        * bfd/elfxx-x86.c (_bfd_x86_elf_create_sframe_plt): Adjust for
	SFrame for IBT PLT.
        * ld/testsuite/ld-x86-64/x86-64.exp: Add new test.
        * ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d: New test.
---
 bfd/elf64-x86-64.c                        | 34 +++++++++++++++++++----
 bfd/elfxx-x86.c                           | 29 ++++++++++---------
 ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d | 33 ++++++++++++++++++++++
 ld/testsuite/ld-x86-64/x86-64.exp         |  1 +
 4 files changed, 79 insertions(+), 18 deletions(-)
 create mode 100644 ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d

diff --git a/bfd/elf64-x86-64.c b/bfd/elf64-x86-64.c
index 4330bbd1648..abbebbe92b4 100644
--- a/bfd/elf64-x86-64.c
+++ b/bfd/elf64-x86-64.c
@@ -906,6 +906,14 @@ static const sframe_frame_row_entry elf_x86_64_sframe_pltn_fre2 =
   SFRAME_V1_FRE_INFO (SFRAME_BASE_REG_SP, 1, SFRAME_FRE_OFFSET_1B) /* FRE info.  */
 };
 
+/* .sframe FRE covering the .plt section entry for IBT.  */
+static const sframe_frame_row_entry elf_x86_64_sframe_ibt_pltn_fre2 =
+{
+  9, /* SFrame FRE start address.  */
+  {16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, /* 12 bytes.  */
+  SFRAME_V1_FRE_INFO (SFRAME_BASE_REG_SP, 1, SFRAME_FRE_OFFSET_1B) /* FRE info.  */
+};
+
 /* .sframe FRE covering the second .plt section entry.  */
 static const sframe_frame_row_entry elf_x86_64_sframe_sec_pltn_fre1 =
 {
@@ -930,7 +938,7 @@ static const struct elf_x86_sframe_plt elf_x86_64_sframe_non_lazy_plt =
   { &elf_x86_64_sframe_null_fre }
 };
 
-/* SFrame helper object for lazy PLT.  Also used for IBT enabled PLT.  */
+/* SFrame helper object for lazy PLT. */
 static const struct elf_x86_sframe_plt elf_x86_64_sframe_plt =
 {
   LAZY_PLT_ENTRY_SIZE,
@@ -942,9 +950,25 @@ static const struct elf_x86_sframe_plt elf_x86_64_sframe_plt =
   /* Array of SFrame FREs for plt.  */
   { &elf_x86_64_sframe_pltn_fre1, &elf_x86_64_sframe_pltn_fre2 },
   NON_LAZY_PLT_ENTRY_SIZE,
-  1, /* Number of FREs for PLTn for second PLT.  */
-  /* FREs for second plt (stack trace info for .plt.got is
-     identical).  Used when IBT or non-lazy PLT is in effect.  */
+  1, /* Number of FREs for second PLT.  */
+  /* Array of SFrame FREs for second PLT.  */
+  { &elf_x86_64_sframe_sec_pltn_fre1 }
+};
+
+/* SFrame helper object for lazy PLT with IBT. */
+static const struct elf_x86_sframe_plt elf_x86_64_sframe_ibt_plt =
+{
+  LAZY_PLT_ENTRY_SIZE,
+  2, /* Number of FREs for PLT0.  */
+  /* Array of SFrame FREs for plt0.  */
+  { &elf_x86_64_sframe_plt0_fre1, &elf_x86_64_sframe_plt0_fre2 },
+  LAZY_PLT_ENTRY_SIZE,
+  2, /* Number of FREs for PLTn.  */
+  /* Array of SFrame FREs for plt.  */
+  { &elf_x86_64_sframe_pltn_fre1, &elf_x86_64_sframe_ibt_pltn_fre2 },
+  LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for second PLT.  */
+  /* Array of SFrame FREs for second plt.  */
   { &elf_x86_64_sframe_sec_pltn_fre1 }
 };
 
@@ -5678,7 +5702,7 @@ elf_x86_64_link_setup_gnu_properties (struct bfd_link_info *info)
     {
       init_table.sframe_lazy_plt = &elf_x86_64_sframe_plt;
       init_table.sframe_non_lazy_plt = &elf_x86_64_sframe_non_lazy_plt;
-      init_table.sframe_lazy_ibt_plt = &elf_x86_64_sframe_plt;
+      init_table.sframe_lazy_ibt_plt = &elf_x86_64_sframe_ibt_plt;
       init_table.sframe_non_lazy_ibt_plt = &elf_x86_64_sframe_non_lazy_plt;
     }
   else
diff --git a/bfd/elfxx-x86.c b/bfd/elfxx-x86.c
index 0d83ce57d4f..cb90f688b6f 100644
--- a/bfd/elfxx-x86.c
+++ b/bfd/elfxx-x86.c
@@ -1831,7 +1831,6 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
   struct elf_x86_link_hash_table *htab;
   const struct elf_backend_data *bed;
 
-  bool plt0_generated_p;
   unsigned int plt0_entry_size;
   unsigned char func_info;
   uint32_t fre_type;
@@ -1845,14 +1844,11 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
   unsigned plt_entry_size = 0;
   unsigned int num_pltn_fres = 0;
   unsigned int num_pltn_entries = 0;
+  const sframe_frame_row_entry * const *pltn_fres;
 
   bed = get_elf_backend_data (output_bfd);
   htab = elf_x86_hash_table (info, bed->target_id);
   /* Whether SFrame stack trace info for plt0 is to be generated.  */
-  plt0_generated_p = htab->plt.has_plt0;
-  plt0_entry_size
-    = (plt0_generated_p) ? htab->sframe_plt->plt0_entry_size : 0;
-
   switch (plt_sec_type)
     {
     case SFRAME_PLT:
@@ -1860,7 +1856,10 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
 	  ectx = &htab->plt_cfe_ctx;
 	  dpltsec = htab->elf.splt;
 
-	  plt_entry_size = htab->plt.plt_entry_size;
+	  plt0_entry_size
+	    = htab->plt.has_plt0 ? htab->sframe_plt->plt0_entry_size : 0;
+	  plt_entry_size = htab->sframe_plt->pltn_entry_size;
+	  pltn_fres = htab->sframe_plt->pltn_fres;
 	  num_pltn_fres = htab->sframe_plt->pltn_num_fres;
 	  num_pltn_entries
 	    = (dpltsec->size - plt0_entry_size) / plt_entry_size;
@@ -1870,12 +1869,15 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
     case SFRAME_PLT_SEC:
 	{
 	  ectx = &htab->plt_second_cfe_ctx;
-	  /* FIXME - this or htab->plt_second_sframe ?  */
-	  dpltsec = htab->plt_second_eh_frame;
+	  dpltsec = htab->plt_second;
+
+	  plt0_entry_size = 0;
 
 	  plt_entry_size = htab->sframe_plt->sec_pltn_entry_size;
+	  pltn_fres = htab->sframe_plt->sec_pltn_fres;
 	  num_pltn_fres = htab->sframe_plt->sec_pltn_num_fres;
 	  num_pltn_entries = dpltsec->size / plt_entry_size;
+
 	  break;
 	}
     default:
@@ -1897,7 +1899,7 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
 
   /* Add SFrame FDE and the associated FREs for plt0 if plt0 has been
      generated.  */
-  if (plt0_generated_p)
+  if (plt0_entry_size)
     {
       /* Add SFrame FDE for plt0, the function start address is updated later
 	 at _bfd_elf_merge_section_sframe time.  */
@@ -1934,16 +1936,17 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
 				      plt0_entry_size, /* func start addr.  */
 				      dpltsec->size - plt0_entry_size,
 				      func_info,
-				      16,
+				      plt_entry_size,
 				      0 /* Num FREs.  */);
 
       sframe_frame_row_entry pltn_fre;
-      /* Now add the FREs for pltn.  Simply adding the two FREs suffices due
+      /* Now add the FREs for pltn.  Simply adding the FREs suffices due
 	 to the usage of SFRAME_FDE_TYPE_PCMASK above.  */
       for (unsigned int j = 0; j < num_pltn_fres; j++)
 	{
-	  pltn_fre = *(htab->sframe_plt->pltn_fres[j]);
-	  sframe_encoder_add_fre (*ectx, 1, &pltn_fre);
+	  unsigned int func_idx = plt0_entry_size ? 1 : 0;
+	  pltn_fre = *(pltn_fres[j]);
+	  sframe_encoder_add_fre (*ectx, func_idx, &pltn_fre);
 	}
     }
 
diff --git a/ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d b/ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d
new file mode 100644
index 00000000000..26be4dfc6a0
--- /dev/null
+++ b/ld/testsuite/ld-x86-64/sframe-ibt-plt-1.d
@@ -0,0 +1,33 @@
+#as: --gsframe
+#source: ibt-plt-3.s
+#objdump: --sframe=.sframe
+#ld: -shared -z ibtplt --no-rosegment
+#name: SFrame for IBT PLT .plt.sec
+
+.*: +file format .*
+
+Contents of the SFrame section .sframe:
+  Header :
+
+    Version: SFRAME_VERSION_2
+    Flags: SFRAME_F_FDE_SORTED
+    CFA fixed RA offset: \-8
+#...
+
+  Function Index :
+
+    func idx \[0\]: pc = 0x1000, size = 16 bytes
+    STARTPC +CFA +FP +RA +
+    0+1000 +sp\+16 +u +f +
+    0+1006 +sp\+24 +u +f +
+
+    func idx \[1\]: pc = 0x1010, size = 32 bytes
+    STARTPC\[m\] +CFA +FP +RA +
+    0+0000 +sp\+8 +u +f +
+    0+0009 +sp\+16 +u +f +
+
+    func idx \[2\]: pc = 0x1030, size = 32 bytes
+    STARTPC\[m\] +CFA +FP +RA +
+    0+0000 +sp\+8 +u +f +
+
+#...
diff --git a/ld/testsuite/ld-x86-64/x86-64.exp b/ld/testsuite/ld-x86-64/x86-64.exp
index bd7574d6965..0632397bccc 100644
--- a/ld/testsuite/ld-x86-64/x86-64.exp
+++ b/ld/testsuite/ld-x86-64/x86-64.exp
@@ -547,6 +547,7 @@ run_dump_test "pr32191-x32"
 if { ![skip_sframe_tests] } {
     run_dump_test "sframe-simple-1"
     run_dump_test "sframe-plt-1"
+    run_dump_test "sframe-ibt-plt-1"
 }
 
 if ![istarget "x86_64-*-linux*"] {
-- 
2.43.0


--kb4yfythcvd7z5d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0003-binutils.patch"

From: Indu Bhagat <indu.bhagat@oracle.com>
Date: Fri, 25 Oct 2024 14:33:21 -0700
To: jpoimboe@kernel.org
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Subject: [PATCH 3/3] ld: generate SFrame stack trace info for .plt.got
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8

PR/32298 sframe: no SFrame stack trace info generated for .plt.got

Add support to generate SFrame stack trace info for .plt.got section.
Enhance the current definition of struct elf_x86_sframe_plt to include
initialized SFrame FDE/FREs applicable for .plt.got section.  There are
two variants of .plt.got entries: 16 byte and 8 byte.

8 byte:
    ff 25 00 00 00 00     jmpq  *name@GOTPCREL(%rip)
    66 90                 xchg  %ax,%ax

16 byte:
    f3 0f 1e fa           endbr64
    ff 25 66 2f 00 00     jmpq  *name@GOTPCREL(%rip)
    66 0f 1f 44 00 00     nopw   0x0(%rax,%rax,1)

For the testcase, define some application symbols such that their PLT
entry is placed in .plt.got and ensure SFrame information is generated
with and without -z ibtplt.

ChangeLog:
	PR/32298
	* bfd/elf64-x86-64.c (elf_x86_64_link_setup_gnu_properties):
	PLT GOT entry size is different for IBT vs non IBT PLTs.
	* bfd/elfxx-x86.c (enum dynobj_sframe_plt_type): New enum for
	SFRAME_PLT_GOT.
	(_bfd_x86_elf_create_sframe_plt): Handle SFRAME_PLT_GOT.
	(_bfd_x86_elf_write_sframe_plt): Likewise.
	(_bfd_x86_elf_late_size_sections): Likewise.
	(_bfd_x86_elf_finish_dynamic_sections): Likewise.
	* bfd/elfxx-x86.h (struct elf_x86_sframe_plt): Add new members
	to keep information about PLT GOT entries.
	(struct elf_x86_link_hash_table): Add support for creating
	SFrame section for .plt.got.
	* ld/testsuite/ld-x86-64/x86-64.exp: Add new tests.
	* ld/testsuite/ld-x86-64/sframe-pltgot-1.d: New test.
	* ld/testsuite/ld-x86-64/sframe-pltgot-1.s: New test.
	* ld/testsuite/ld-x86-64/sframe-pltgot-2.d: New test.
---
 bfd/elf64-x86-64.c                       | 42 ++++++++++--
 bfd/elfxx-x86.c                          | 86 ++++++++++++++++++++++--
 bfd/elfxx-x86.h                          |  6 ++
 ld/testsuite/ld-x86-64/sframe-pltgot-1.d | 28 ++++++++
 ld/testsuite/ld-x86-64/sframe-pltgot-1.s | 15 +++++
 ld/testsuite/ld-x86-64/sframe-pltgot-2.d | 28 ++++++++
 ld/testsuite/ld-x86-64/x86-64.exp        |  2 +
 7 files changed, 198 insertions(+), 9 deletions(-)
 create mode 100644 ld/testsuite/ld-x86-64/sframe-pltgot-1.d
 create mode 100644 ld/testsuite/ld-x86-64/sframe-pltgot-1.s
 create mode 100644 ld/testsuite/ld-x86-64/sframe-pltgot-2.d

diff --git a/bfd/elf64-x86-64.c b/bfd/elf64-x86-64.c
index abbebbe92b4..a62fa621f99 100644
--- a/bfd/elf64-x86-64.c
+++ b/bfd/elf64-x86-64.c
@@ -922,7 +922,7 @@ static const sframe_frame_row_entry elf_x86_64_sframe_sec_pltn_fre1 =
   SFRAME_V1_FRE_INFO (SFRAME_BASE_REG_SP, 1, SFRAME_FRE_OFFSET_1B) /* FRE info.  */
 };
 
-/* SFrame helper object for non-lazy PLT.  Also used for IBT enabled PLT.  */
+/* SFrame helper object for non-lazy PLT.  */
 static const struct elf_x86_sframe_plt elf_x86_64_sframe_non_lazy_plt =
 {
   LAZY_PLT_ENTRY_SIZE,
@@ -935,7 +935,31 @@ static const struct elf_x86_sframe_plt elf_x86_64_sframe_non_lazy_plt =
   { &elf_x86_64_sframe_sec_pltn_fre1, &elf_x86_64_sframe_null_fre },
   0,
   0, /* There is no second PLT necessary.  */
-  { &elf_x86_64_sframe_null_fre }
+  { &elf_x86_64_sframe_null_fre },
+  NON_LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for PLT GOT.  */
+  /* Array of SFrame FREs for PLT GOT.  */
+  { &elf_x86_64_sframe_null_fre },
+};
+
+/* SFrame helper object for non-lazy IBT enabled PLT.  */
+static const struct elf_x86_sframe_plt elf_x86_64_sframe_non_lazy_ibt_plt =
+{
+  LAZY_PLT_ENTRY_SIZE,
+  2, /* Number of FREs for PLT0.  */
+  /* Array of SFrame FREs for plt0.  */
+  { &elf_x86_64_sframe_plt0_fre1, &elf_x86_64_sframe_plt0_fre2 },
+  LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for PLTn.  */
+  /* Array of SFrame FREs for plt.  */
+  { &elf_x86_64_sframe_sec_pltn_fre1, &elf_x86_64_sframe_null_fre },
+  0,
+  0, /* There is no second PLT necessary.  */
+  { &elf_x86_64_sframe_null_fre },
+  LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for PLT GOT.  */
+  /* Array of SFrame FREs for PLT GOT.  */
+  { &elf_x86_64_sframe_null_fre },
 };
 
 /* SFrame helper object for lazy PLT. */
@@ -952,7 +976,11 @@ static const struct elf_x86_sframe_plt elf_x86_64_sframe_plt =
   NON_LAZY_PLT_ENTRY_SIZE,
   1, /* Number of FREs for second PLT.  */
   /* Array of SFrame FREs for second PLT.  */
-  { &elf_x86_64_sframe_sec_pltn_fre1 }
+  { &elf_x86_64_sframe_sec_pltn_fre1 },
+  NON_LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for PLT GOT.  */
+  /* Array of SFrame FREs for PLT GOT.  */
+  { &elf_x86_64_sframe_null_fre },
 };
 
 /* SFrame helper object for lazy PLT with IBT. */
@@ -969,7 +997,11 @@ static const struct elf_x86_sframe_plt elf_x86_64_sframe_ibt_plt =
   LAZY_PLT_ENTRY_SIZE,
   1, /* Number of FREs for second PLT.  */
   /* Array of SFrame FREs for second plt.  */
-  { &elf_x86_64_sframe_sec_pltn_fre1 }
+  { &elf_x86_64_sframe_sec_pltn_fre1 },
+  LAZY_PLT_ENTRY_SIZE,
+  1, /* Number of FREs for PLT GOT.  */
+  /* Array of SFrame FREs for PLT GOT.  */
+  { &elf_x86_64_sframe_null_fre },
 };
 
 /* These are the standard parameters.  */
@@ -5703,7 +5735,7 @@ elf_x86_64_link_setup_gnu_properties (struct bfd_link_info *info)
       init_table.sframe_lazy_plt = &elf_x86_64_sframe_plt;
       init_table.sframe_non_lazy_plt = &elf_x86_64_sframe_non_lazy_plt;
       init_table.sframe_lazy_ibt_plt = &elf_x86_64_sframe_ibt_plt;
-      init_table.sframe_non_lazy_ibt_plt = &elf_x86_64_sframe_non_lazy_plt;
+      init_table.sframe_non_lazy_ibt_plt = &elf_x86_64_sframe_non_lazy_ibt_plt;
     }
   else
     {
diff --git a/bfd/elfxx-x86.c b/bfd/elfxx-x86.c
index cb90f688b6f..0843803171b 100644
--- a/bfd/elfxx-x86.c
+++ b/bfd/elfxx-x86.c
@@ -1817,7 +1817,8 @@ elf_x86_relative_reloc_compare (const void *pa, const void *pb)
 enum dynobj_sframe_plt_type
 {
   SFRAME_PLT = 1,
-  SFRAME_PLT_SEC = 2
+  SFRAME_PLT_SEC = 2,
+  SFRAME_PLT_GOT = 3,
 };
 
 /* Create SFrame stack trace info for the plt entries in the .plt section
@@ -1880,6 +1881,21 @@ _bfd_x86_elf_create_sframe_plt (bfd *output_bfd,
 
 	  break;
 	}
+      case SFRAME_PLT_GOT:
+	{
+	  ectx = &htab->plt_got_cfe_ctx;
+	  dpltsec = htab->plt_got;
+
+	  plt0_entry_size = 0;
+
+	  plt_entry_size = htab->sframe_plt->plt_got_entry_size;
+	  pltn_fres = htab->sframe_plt->plt_got_fres;
+	  num_pltn_fres = htab->sframe_plt->plt_got_num_fres;
+	  num_pltn_entries = dpltsec->size / plt_entry_size;
+
+	  break;
+	}
+
     default:
       /* No other value is possible.  */
       return false;
@@ -1984,6 +2000,10 @@ _bfd_x86_elf_write_sframe_plt (bfd *output_bfd,
       ectx = htab->plt_second_cfe_ctx;
       sec = htab->plt_second_sframe;
       break;
+    case SFRAME_PLT_GOT:
+      ectx = htab->plt_got_cfe_ctx;
+      sec = htab->plt_got_sframe;
+      break;
     default:
       /* No other value is possible.  */
       return false;
@@ -2511,7 +2531,18 @@ _bfd_x86_elf_late_size_sections (bfd *output_bfd,
 	  htab->plt_sframe->size = sizeof (sframe_header) + 1;
 	}
 
-      /* FIXME - generate for .plt.got ?  */
+      if (htab->plt_got_sframe != NULL
+	  && htab->plt_got != NULL
+	  && htab->plt_got->size != 0
+	  && !bfd_is_abs_section (htab->plt_got->output_section))
+	{
+	  _bfd_x86_elf_create_sframe_plt (output_bfd, info, SFRAME_PLT_GOT);
+	  /* FIXME - Dirty Hack.  Set the size to something non-zero for now,
+	     so that the section does not get stripped out below.  The precise
+	     size of this section is known only when the contents are
+	     serialized in _bfd_x86_elf_write_sframe_plt.  */
+	  htab->plt_got_sframe->size = sizeof (sframe_header) + 1;
+	}
 
       if (htab->plt_second_sframe != NULL
 	  && htab->plt_second != NULL
@@ -2578,6 +2609,7 @@ _bfd_x86_elf_late_size_sections (bfd *output_bfd,
 	       || s == htab->plt_second_eh_frame
 	       || s == htab->plt_sframe
 	       || s == htab->plt_second_sframe
+	       || s == htab->plt_got_sframe
 	       || s == htab->elf.sdynbss
 	       || s == htab->elf.sdynrelro)
 	{
@@ -2622,7 +2654,8 @@ _bfd_x86_elf_late_size_sections (bfd *output_bfd,
 
       /* Skip allocating contents for .sframe section as it is written
 	 out differently.  See below.  */
-      if ((s == htab->plt_sframe) || (s == htab->plt_second_sframe))
+      if ((s == htab->plt_sframe) || (s == htab->plt_second_sframe)
+	  || (s == htab->plt_got_sframe))
 	continue;
 
       /* NB: Initially, the iplt section has minimal alignment to
@@ -2687,6 +2720,12 @@ _bfd_x86_elf_late_size_sections (bfd *output_bfd,
 	  && htab->plt_second->size != 0
 	  && htab->plt_second_sframe->contents == NULL)
 	_bfd_x86_elf_write_sframe_plt (output_bfd, info, SFRAME_PLT_SEC);
+
+      if (htab->plt_got_sframe != NULL
+	  && htab->plt_got != NULL
+	  && htab->plt_got->size != 0
+	  && htab->plt_got_sframe->contents == NULL)
+	_bfd_x86_elf_write_sframe_plt (output_bfd, info, SFRAME_PLT_GOT);
     }
 
   if (resolved_plt != NULL
@@ -2997,6 +3036,34 @@ _bfd_x86_elf_finish_dynamic_sections (bfd *output_bfd,
 	    return NULL;
 	}
     }
+
+  if (htab->plt_got_sframe != NULL
+      && htab->plt_got_sframe->contents != NULL)
+    {
+      if (htab->plt_got != NULL
+	  && htab->plt_got->size != 0
+	  && (htab->plt_got->flags & SEC_EXCLUDE) == 0
+	  && htab->plt_got->output_section != NULL
+	  && htab->plt_got_sframe->output_section != NULL)
+	{
+	  bfd_vma plt_start = htab->plt_got->output_section->vma;
+	  bfd_vma sframe_start
+	    = (htab->plt_got_sframe->output_section->vma
+	       + htab->plt_got_sframe->output_offset
+	       + PLT_SFRAME_FDE_START_OFFSET);
+	  bfd_put_signed_32 (dynobj, plt_start - sframe_start,
+			     htab->plt_got_sframe->contents
+			     + PLT_SFRAME_FDE_START_OFFSET);
+	}
+      if (htab->plt_got_sframe->sec_info_type == SEC_INFO_TYPE_SFRAME)
+	{
+	  if (! _bfd_elf_merge_section_sframe (output_bfd, info,
+					       htab->plt_got_sframe,
+					       htab->plt_got_sframe->contents))
+	    return NULL;
+	}
+    }
+
   if (htab->elf.sgot && htab->elf.sgot->size > 0)
     elf_section_data (htab->elf.sgot->output_section)->this_hdr.sh_entsize
       = htab->got_entry_size;
@@ -4764,7 +4831,18 @@ _bfd_x86_elf_link_setup_gnu_properties
 
 	      htab->plt_second_sframe = sec;
 	    }
-	  /* FIXME - add later for plt_got. */
+
+	  /* .plt.got.  */
+	  if (htab->plt_got != NULL)
+	    {
+	      sec = bfd_make_section_anyway_with_flags (dynobj,
+							".sframe",
+							flags);
+	      if (sec == NULL)
+		info->callbacks->einfo (_("%F%P: failed to create PLT GOT .sframe section\n"));
+
+	      htab->plt_got_sframe = sec;
+	    }
 	}
     }
 
diff --git a/bfd/elfxx-x86.h b/bfd/elfxx-x86.h
index b042d45c282..cd26e8fc6f2 100644
--- a/bfd/elfxx-x86.h
+++ b/bfd/elfxx-x86.h
@@ -401,6 +401,10 @@ struct elf_x86_sframe_plt
   unsigned int sec_pltn_entry_size;
   unsigned int sec_pltn_num_fres;
   const sframe_frame_row_entry *sec_pltn_fres[SFRAME_PLTN_MAX_NUM_FRES];
+
+  unsigned int plt_got_entry_size;
+  unsigned int plt_got_num_fres;
+  const sframe_frame_row_entry *plt_got_fres[SFRAME_PLTN_MAX_NUM_FRES];
 };
 
 struct elf_x86_lazy_plt_layout
@@ -606,6 +610,8 @@ struct elf_x86_link_hash_table
   asection *plt_sframe;
   sframe_encoder_ctx *plt_second_cfe_ctx;
   asection *plt_second_sframe;
+  sframe_encoder_ctx *plt_got_cfe_ctx;
+  asection *plt_got_sframe;
 
   /* Parameters describing PLT generation, lazy or non-lazy.  */
   struct elf_x86_plt_layout plt;
diff --git a/ld/testsuite/ld-x86-64/sframe-pltgot-1.d b/ld/testsuite/ld-x86-64/sframe-pltgot-1.d
new file mode 100644
index 00000000000..e26a741b635
--- /dev/null
+++ b/ld/testsuite/ld-x86-64/sframe-pltgot-1.d
@@ -0,0 +1,28 @@
+#as: --gsframe
+#source: sframe-pltgot-1.s
+#objdump: --sframe=.sframe
+#ld: -shared -z ibtplt --no-rosegment
+#name: SFrame for .plt.got
+
+.*: +file format .*
+
+Contents of the SFrame section .sframe:
+  Header :
+
+    Version: SFRAME_VERSION_2
+    Flags: SFRAME_F_FDE_SORTED
+    CFA fixed RA offset: \-8
+#...
+
+  Function Index :
+
+    func idx \[0\]: pc = 0x1000, size = 16 bytes
+    STARTPC +CFA +FP +RA +
+    0+1000 +sp\+16 +u +f +
+    0+1006 +sp\+24 +u +f +
+
+    func idx \[1\]: pc = 0x1010, size = 64 bytes
+    STARTPC\[m\] +CFA +FP +RA +
+    0+0000 +sp\+16 +u +f +
+
+#...
diff --git a/ld/testsuite/ld-x86-64/sframe-pltgot-1.s b/ld/testsuite/ld-x86-64/sframe-pltgot-1.s
new file mode 100644
index 00000000000..e596e846439
--- /dev/null
+++ b/ld/testsuite/ld-x86-64/sframe-pltgot-1.s
@@ -0,0 +1,15 @@
+        .text
+        .globl foo
+        .type foo, @function
+foo:
+        .cfi_startproc
+        call    func1@plt
+        movq    func1@GOTPCREL(%rip), %rax
+        call    func2@plt
+        movq    func2@GOTPCREL(%rip), %rax
+        call    func3@plt
+        movq    func3@GOTPCREL(%rip), %rax
+        call    func4@plt
+        movq    func4@GOTPCREL(%rip), %rax
+        .cfi_endproc
+	.section	.note.GNU-stack,"",@progbits
diff --git a/ld/testsuite/ld-x86-64/sframe-pltgot-2.d b/ld/testsuite/ld-x86-64/sframe-pltgot-2.d
new file mode 100644
index 00000000000..7a99d12faa8
--- /dev/null
+++ b/ld/testsuite/ld-x86-64/sframe-pltgot-2.d
@@ -0,0 +1,28 @@
+#as: --gsframe
+#source: sframe-pltgot-1.s
+#objdump: --sframe=.sframe
+#ld: -shared --no-rosegment
+#name: SFrame for .plt.got
+
+.*: +file format .*
+
+Contents of the SFrame section .sframe:
+  Header :
+
+    Version: SFRAME_VERSION_2
+    Flags: SFRAME_F_FDE_SORTED
+    CFA fixed RA offset: \-8
+#...
+
+  Function Index :
+
+    func idx \[0\]: pc = 0x1000, size = 16 bytes
+    STARTPC +CFA +FP +RA +
+    0+1000 +sp\+16 +u +f +
+    0+1006 +sp\+24 +u +f +
+
+    func idx \[1\]: pc = 0x1010, size = 32 bytes
+    STARTPC\[m\] +CFA +FP +RA +
+    0+0000 +sp\+16 +u +f +
+
+#...
diff --git a/ld/testsuite/ld-x86-64/x86-64.exp b/ld/testsuite/ld-x86-64/x86-64.exp
index 0632397bccc..a66d28eb0d1 100644
--- a/ld/testsuite/ld-x86-64/x86-64.exp
+++ b/ld/testsuite/ld-x86-64/x86-64.exp
@@ -548,6 +548,8 @@ if { ![skip_sframe_tests] } {
     run_dump_test "sframe-simple-1"
     run_dump_test "sframe-plt-1"
     run_dump_test "sframe-ibt-plt-1"
+    run_dump_test "sframe-pltgot-1"
+    run_dump_test "sframe-pltgot-2"
 }
 
 if ![istarget "x86_64-*-linux*"] {
-- 
2.43.0


--kb4yfythcvd7z5d5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="glibc.patch"

diff --git a/elf/dl-load.c b/elf/dl-load.c
index 2923b1141d..ffaf722f5f 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -29,6 +29,7 @@
 #include <bits/wordsize.h>
 #include <sys/mman.h>
 #include <sys/param.h>
+#include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <gnu/lib-names.h>
@@ -88,6 +89,10 @@ struct filebuf
 
 #define STRING(x) __STRING (x)
 
+#ifndef PT_GNU_SFRAME
+#define PT_GNU_SFRAME 0x6474e554
+#endif
+
 
 int __stack_prot attribute_hidden attribute_relro
 #if _STACK_GROWS_DOWN && defined PROT_GROWSDOWN
@@ -1213,6 +1218,10 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	  l->l_relro_addr = ph->p_vaddr;
 	  l->l_relro_size = ph->p_memsz;
 	  break;
+
+	case PT_GNU_SFRAME:
+	  l->l_sframe_addr = ph->p_vaddr;
+	  break;
 	}
 
     if (__glibc_unlikely (nloadcmds == 0))
@@ -1376,6 +1385,13 @@ cannot enable executable stack as shared object requires");
 	break;
       }
 
+#define PR_ADD_SFRAME 74
+  if (l->l_sframe_addr != 0)
+  {
+    l->l_sframe_addr += l->l_addr;
+    __prctl(PR_ADD_SFRAME, l->l_sframe_addr, NULL, NULL, NULL);
+  }
+
   /* We are done mapping in the file.  We no longer need the descriptor.  */
   if (__glibc_unlikely (__close_nocancel (fd) != 0))
     {
diff --git a/elf/dl-unmap-segments.h b/elf/dl-unmap-segments.h
index 1ec507e887..c4a7e9e0ed 100644
--- a/elf/dl-unmap-segments.h
+++ b/elf/dl-unmap-segments.h
@@ -21,14 +21,20 @@
 
 #include <link.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 
 /* _dl_map_segments ensures that any whole pages in gaps between segments
    are filled in with PROT_NONE mappings.  So we can just unmap the whole
    range in one fell swoop.  */
 
+#define PR_REMOVE_SFRAME 75
+
 static __always_inline void
 _dl_unmap_segments (struct link_map *l)
 {
+  if (l->l_sframe_addr != 0)
+    __prctl(PR_REMOVE_SFRAME, l->l_sframe_addr, NULL, NULL, NULL);
+
   __munmap ((void *) l->l_map_start, l->l_map_end - l->l_map_start);
 }
 
diff --git a/include/link.h b/include/link.h
index c6af095d87..36ac75680f 100644
--- a/include/link.h
+++ b/include/link.h
@@ -348,6 +348,8 @@ struct link_map
     ElfW(Addr) l_relro_addr;
     size_t l_relro_size;
 
+    ElfW(Addr) l_sframe_addr;
+
     unsigned long long int l_serial;
   };
 

--kb4yfythcvd7z5d5--
