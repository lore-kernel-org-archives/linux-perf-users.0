Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8432255A;
	Tue,  9 Sep 2025 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418034; cv=pass; b=GRDonhkMFdPT8Qqn5jQEYdoAHJ+xmmEQuQhnkf7ZMGbtFlSRPkqjbxZ1X3T4BPL1iSGWdRxtdlpTPj8vMydTlnfzVR2bpsnNg7ud7jUnLqf4nuuY42gL8g85LuVRb5nB5/1wx52vlfUiEMNEUJcqjK0IdMmvJt2JOA1NXm2EtQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418034; c=relaxed/simple;
	bh=yyH7QXAmga8o9wPBkSK0dhxZ1ZIsY8aNE12IRqdxdfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5IT+2e/UcZbm3jyyL8B4mC3+KbL/MPeuv573G4G8WuG8sTvlyp2nueRleA/dpsJk6b2bLoU02dxnB6dI1WfDNiGm5jnjg7vdEd/eOWYuo2i5SssjETbnIwuSnK1muVb7T7lJG6ourtc9pYJ4s6nAEMJpgEsW9sI+0XCOjMoAJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Mdkmplj7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Mdkmplj7"
ARC-Seal: i=1; a=rsa-sha256; t=1757418007; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mR86WgNDJqm43kd30guAp2bJpPVNH/BT6nkeYpDZzS1ORtrOjSmo+ZOR/wzvyilYD+qzoMb9+fRz9xnagSmOpuyI2PYbpo/Ib3INKzS+4jcgnvBRPc2EF6kOWbghJTlva6RbJ20T9ZSOhavTJ33RRsBiAWHTmOqqwOK9WeAlzXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757418007; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AKWUdCalq5DHy3CQODfUq4gtyG6Ka3mIdSwhVwGWp2Q=; 
	b=bo+vzUYHG9MJQK4YrDvVjL0t+wlzJoasp1ALS9t4j4wGCp7L7auxhZbVlJHMZBz7JbxjpN0InAy/xVn1Msc2hJs5yzZ/nwky7zm2rnB/RIhi8TxSPLjr9DndAkc397CPHUyJFjWw4YhPX2pVvGgB4Sb12ViSIA4WLfZS6+T5KOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757418007;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AKWUdCalq5DHy3CQODfUq4gtyG6Ka3mIdSwhVwGWp2Q=;
	b=Mdkmplj7jW+S3Tq/XJlTuR/ujV2l/R5gsbdJ76/rZSvz4MUtFPOCvBZdc237oOzU
	vb5ix2ya7nDM791RnGrRt/lqlc5CEOkSW0Bj26HqxY4HSVLm0BhLDv4vjouD9xjFr5D
	0wjN1Yjd2IQCer0XDKeuZ3sTFdJUoHMjMnZ93SQY=
Received: by mx.zohomail.com with SMTPS id 1757418005705920.7142783931457;
	Tue, 9 Sep 2025 04:40:05 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	kernel@collabora.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: [PATCH RESEND v2] perf/headers: Document PERF_PMU_CAP capability flags
Date: Tue,  9 Sep 2025 13:39:37 +0200
Message-ID: <20250909-perf-pmu-cap-docs-v2-1-3c451f7b0b2e@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable

Over the years, capability flags for perf PMUs were introduced in a=0D
piecemeal fashion whenever a new driver needed to signal to the perf=0D
core some limitation or special feature.=0D
=0D
Since one more undocumented flag that can have its meaning inferred from=0D
the commit message and implementation never seems that bad, it's=0D
understandable that this resulted in a total of 11 undocumented=0D
capability flags, which authors of new perf PMU drivers are expected to=0D
set correctly for their particular device.=0D
=0D
Since I am in the process of becoming such an author of a new perf=0D
driver, it feels proper to pay it forward by documenting all=0D
PERF_PMU_CAP_ constants, so that no future person has to go through an=0D
hour or two of git blame + reading perf core code to figure out which=0D
capability flags are right for them.=0D
=0D
Add comments in kernel-doc format that describes each flag. This follows=0D
the somewhat verbose "Object-like macro documentation" format, and can=0D
be verified with=0D
=0D
	./scripts/kernel-doc -v -none include/linux/perf_event.h=0D
=0D
The current in-tree kernel documentation does not include a page on the=0D
perf subsystem, but once it does, these comments should render as proper=0D
documentation annotation. Until then, they'll also be quite useful for=0D
anyone looking at the header file.=0D
=0D
Reviewed-by: James Clark <james.clark@linaro.org>=0D
Reviewed-by: Ian Rogers <irogers@google.com>=0D
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>=0D
---=0D
Changes in v2:=0D
- Fixed the description of PERF_PMU_CAP_NO_INTERRUPT and expanded it to=0D
  make it clearer for driver authors whether this flag is right for them=0D
- Made PERF_PMU_CAP_NO_EXCLUDE docs mention the precise attributes the=0D
  flag concerns itself with, as suggested by Peter Zijlstra=0D
- Link to v1: https://lore.kernel.org/r/20250618-perf-pmu-cap-docs-v1-1-0d3=
4387d6e47@collabora.com=0D
---=0D
 include/linux/perf_event.h | 85 ++++++++++++++++++++++++++++++++++++++++++=
++++=0D
 1 file changed, 85 insertions(+)=0D
=0D
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h=0D
index ec9d96025683958e909bb2463439dc69634f4ceb..d0e6b66cfd268bdad742b707633=
792f26352a428 100644=0D
--- a/include/linux/perf_event.h=0D
+++ b/include/linux/perf_event.h=0D
@@ -294,16 +294,101 @@ struct perf_event_pmu_context;=0D
 /**=0D
  * pmu::capabilities flags=0D
  */=0D
+=0D
+/**=0D
+ * define PERF_PMU_CAP_NO_INTERRUPT - \=0D
+ *    PMU is incapable of generating samples=0D
+ *=0D
+ * On CPU PMU hardware, a PMU driver is only capable of generating sample =
data=0D
+ * in the form of &struct perf_sample_data if the hardware is capable of=0D
+ * generating hardware interrupts. If such interrupt capability is missing=
,=0D
+ * this flag should be set.=0D
+ *=0D
+ * Uncore drivers, i.e. drivers for hardware performance counters that are=
 not=0D
+ * closely entwined with CPUs and their model of execution, should also se=
t=0D
+ * this flag, as they are not able to generate meaningful sample data, eve=
n if=0D
+ * they do use an interrupt for some purpose.=0D
+ */=0D
 #define PERF_PMU_CAP_NO_INTERRUPT	0x0001=0D
+/**=0D
+ * define PERF_PMU_CAP_NO_NMI - \=0D
+ *    PMU is guaranteed to not generate non-maskable interrupts=0D
+ */=0D
 #define PERF_PMU_CAP_NO_NMI		0x0002=0D
+/**=0D
+ * define PERF_PMU_CAP_AUX_NO_SG - \=0D
+ *    PMU does not support using scatter-gather as the output=0D
+ *=0D
+ * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support=
=0D
+ * scatter-gather for its output buffer, and needs a larger contiguous buf=
fer=0D
+ * to output to.=0D
+ */=0D
 #define PERF_PMU_CAP_AUX_NO_SG		0x0004=0D
+/**=0D
+ * define PERF_PMU_CAP_EXTENDED_REGS - \=0D
+ *    PMU is capable of sampling extended registers=0D
+ *=0D
+ * Some architectures have a concept of extended registers, e.g. XMM0 on x=
86=0D
+ * or VG on arm64. If the PMU is capable of sampling these registers, then=
 the=0D
+ * flag PERF_PMU_CAP_EXTENDED_REGS should be set.=0D
+ */=0D
 #define PERF_PMU_CAP_EXTENDED_REGS	0x0008=0D
+/**=0D
+ * define PERF_PMU_CAP_EXCLUSIVE - \=0D
+ *    PMU can only have one scheduled event at a time=0D
+ *=0D
+ * Certain PMU hardware cannot track several events at the same time. Such=
=0D
+ * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.=0D
+ */=0D
 #define PERF_PMU_CAP_EXCLUSIVE		0x0010=0D
+/**=0D
+ * define PERF_PMU_CAP_ITRACE - PMU traces instructions=0D
+ *=0D
+ * Some PMU hardware does instruction tracing, in that it traces execution=
 of=0D
+ * each instruction. Setting this capability flag makes the perf core gene=
rate=0D
+ * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID an=
d TID,=0D
+ * to allow tools to properly decode such traces.=0D
+ */=0D
 #define PERF_PMU_CAP_ITRACE		0x0020=0D
+/**=0D
+ * define PERF_PMU_CAP_NO_EXCLUDE - \=0D
+ *    PMU is incapable of excluding events based on context=0D
+ *=0D
+ * The PERF_PMU_CAP_NO_EXCLUDE flag, when set, makes the perf core reject =
any=0D
+ * request for an event that has one of the attributes=0D
+ * perf_event_attr::exclude_{user,kernel,hv,idle,host,guest} set.=0D
+ *=0D
+ * Drivers for PMU hardware that cannot distinguish between these differen=
t=0D
+ * execution contexts should set this flag.=0D
+ */=0D
 #define PERF_PMU_CAP_NO_EXCLUDE		0x0040=0D
+/**=0D
+ * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data=0D
+ *=0D
+ * Drivers for PMU hardware that supports non-AUX events which generate da=
ta for=0D
+ * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf=
 core=0D
+ * to schedule non-AUX events together with AUX events, so that this data =
isn't=0D
+ * lost.=0D
+ */=0D
 #define PERF_PMU_CAP_AUX_OUTPUT		0x0080=0D
+/**=0D
+ * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \=0D
+ *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE=0D
+ */=0D
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100=0D
+/**=0D
+ * define PERF_PMU_CAP_AUX_PAUSE - \=0D
+ *    PMU can pause and resume AUX area traces based on events=0D
+ */=0D
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200=0D
+/**=0D
+ * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output bu=
ffers=0D
+ *=0D
+ * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict vari=
ant of=0D
+ * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly=
=0D
+ * require contiguous output buffers, but find the benefits outweigh the=0D
+ * downside of increased memory fragmentation, may set this capability fla=
g.=0D
+ */=0D
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400=0D
 =0D
 /**=0D
=0D
---=0D
base-commit: 1d07605c859ee3f483f07acd461452d9e505c58c=0D
change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac=0D
=0D
Best regards,=0D
-- =0D
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>=0D
=0D
