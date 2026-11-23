Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421315;
	b=u/wUosvcttJ/uEs/CmPUeRpK+h+onr+U1zSo06qmIzFNjUa1iSDPinTzlepR7eW9qLb0
	 ic8TgC5j7jPYxZFcavZ/pbT1KF4EzwZml5PHEmWTieS0w9EmoiNqXL69gssuj+3MyjZYh
	 DTLpUAp1japtJFi0hyPZzwSUQnp1qdRjMR2x6rd9iK2FS4XgpD/0yrmwhQ3Yp20fAjpM+
	 A+XbTIaP4iLrTf6ZKq5dHWQlQ0ZeSwjOc3zdHX/mRxMDHbqfMhoN1aUyCpMWM+gEHfKo5
	 PBUb/jeD0yC8pnB9+BpPTC4cOstQuQXPsvx8QB+ulCwNZFHBhWdrChUmpqnWAUIx+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421315;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=8XFStxtIyu/bWdCANZfW2ox1JdG4p0sGe2XRHxMcJOI=;
	b=daQzAqPnxXuAh1pFT52q53A6fJxaaYQlaBHC6SOz3VrkT1Z/MO0MkkYvCf0zahzkgcpR
	 qUQ0EsKf5dj+bVxCYD7f3Yi7u24BAbW0w4zwKMprUU6xaI3MDr9c9oyWXScViBf+uBDEh
	 MJ1zi/Wcj0uMg9HWBKLlJ8me3ksdWY6qZHmUNjLXB/5iJ+aTN0Luj3FarRTK6gr945YHA
	 N6Wdex9RtAF3dzfIelAaxViut2iV+PlQ5/7B8WRGot9sDmMBYD6x6P1lKA5qQrAeliYCg
	 6AEhx35PFsYgoTIaGs6kbzfA6HPR09P6+pAW4DvGDGgb0mPGDztXGpPodOEsAT77ykQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ujBumtdu;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ujBumtdu;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7C606A31A;
	Mon, 23 Nov 2026 08:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ujBumtdu;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=ujBumtdu
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EE2722091;
	Mon, 23 Nov 2026 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795421306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8XFStxtIyu/bWdCANZfW2ox1JdG4p0sGe2XRHxMcJOI=;
	b=ujBumtdu5qabRFa2EmZPloprrS6teEXfopGm/yvpXJYyt6wNfXMayH4+fb3exsccFOlZIr
	BM1l/Dm0zvtd1Be+DIZvinUM9QLsKwWD9ldAKQpAMZ3DJSiyCElSJmvGEv8x9eMnbCoR7Z
	fvTdcMI9CBnl3MnQrxFh29ojEf/WVJE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ujBumtdu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1795421306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8XFStxtIyu/bWdCANZfW2ox1JdG4p0sGe2XRHxMcJOI=;
	b=ujBumtdu5qabRFa2EmZPloprrS6teEXfopGm/yvpXJYyt6wNfXMayH4+fb3exsccFOlZIr
	BM1l/Dm0zvtd1Be+DIZvinUM9QLsKwWD9ldAKQpAMZ3DJSiyCElSJmvGEv8x9eMnbCoR7Z
	fvTdcMI9CBnl3MnQrxFh29ojEf/WVJE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 949B713510;
	Mon, 23 Nov 2026 08:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ezOKG3n0A2u9TwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 23 Nov 2026 08:08:25 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Tony Luck <tony.luck@intel.com>,
	Ashok Raj <ashok.raj.linux@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] msr: replace rdmsr()/wrmsr() in comments
Date: Mon, 23 Nov 2026 09:08:22 +0100
Message-ID: <20261123080822.3426355-1-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EE2722091
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-10.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,lwn.net,linuxfoundation.org,infradead.org,arm.com,google.com,intel.com,linaro.org,roeck-us.net,gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.51

Replace all mentioning of rdmsr() and wrmsr() in comments with
rdmsrq() and wrmsrq(), as the former functions are no longer
existing.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
To be applied on top of current core/msr branch of the tip tree.

 Documentation/arch/x86/microcode.rst  | 2 +-
 arch/x86/events/amd/ibs.c             | 2 +-
 arch/x86/events/intel/core.c          | 2 +-
 arch/x86/events/intel/lbr.c           | 6 +++---
 arch/x86/include/asm/shared/msr.h     | 2 +-
 arch/x86/kernel/cpu/feat_ctl.c        | 2 +-
 drivers/hwmon/coretemp.c              | 2 +-
 drivers/platform/x86/intel/ifs/load.c | 5 +++--
 8 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/x86/microcode.rst b/Documentation/arch/x86/microcode.rst
index b627c6f36bcf..df1fb2c82333 100644
--- a/Documentation/arch/x86/microcode.rst
+++ b/Documentation/arch/x86/microcode.rst
@@ -151,7 +151,7 @@ are also treated as fatal by the kernel.
 On certain Intel machines, MCEs are also broadcast to all threads in a
 system. If one thread is in the middle of executing WRMSR, a MCE will be
 taken at the end of the flow. Either way, they will wait for the thread
-performing the wrmsr(0x79) to rendezvous in the MCE handler and shutdown
+performing the wrmsrq(0x79) to rendezvous in the MCE handler and shutdown
 eventually if any of the threads in the system fail to check in to the
 MCE rendezvous.
 
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index f43949bde19c..2ef0530b6561 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -591,7 +591,7 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 		 *  o Set VAL bit            CTL2[Dis] = 1
 		 *  o Raise NMI --.        o ...
 		 *                 \       o ->start()
-		 *                  \        wrmsr(IBS_{FETCH|OP}_CTL, new value);
+		 *                  \        wrmsrq(IBS_{FETCH|OP}_CTL, new value);
 		 *                   \       (wrmsr clears the VAL bit)
 		 *                    `--> o Receives delayed NMI
 		 *                           (Unknown NMI since VAL bit is cleared)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 96bcbf823aec..1b6213ef2ced 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6963,7 +6963,7 @@ static bool check_msr(unsigned long msr, u64 mask)
 		return false;
 
 	/*
-	 * Quirk only affects validation in wrmsr(), so wrmsrq()'s value
+	 * Quirk only affects validation in wrmsrq(), so wrmsrq()'s value
 	 * should equal rdmsrq()'s even with the quirk.
 	 */
 	if (val_new != val_tmp)
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index beac04502b73..760d5e465a56 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -222,7 +222,7 @@ enum {
  * are the TSX flags when TSX is supported, but when TSX is not supported
  * they have no consistent behavior:
  *
- *   - For wrmsr(), bits 61:62 are considered part of the sign extension.
+ *   - For wrmsrq(), bits 61:62 are considered part of the sign extension.
  *   - For HW updates (branch captures) bits 61:62 are always OFF and are not
  *     part of the sign extension.
  *
@@ -231,8 +231,8 @@ enum {
  *   1) LBR format LBR_FORMAT_EIP_FLAGS2
  *   2) CPU has no TSX support enabled
  *
- * ... then any value passed to wrmsr() must be sign extended to 63 bits and any
- * value from rdmsr() must be converted to have a 61 bits sign extension,
+ * ... then any value passed to wrmsrq() must be sign extended to 63 bits and
+ * any value from rdmsrq() must be converted to have a 61 bits sign extension,
  * ignoring the TSX flags.
  */
 static inline bool lbr_from_signext_quirk_needed(void)
diff --git a/arch/x86/include/asm/shared/msr.h b/arch/x86/include/asm/shared/msr.h
index a20b1c08c99f..c46188ca5403 100644
--- a/arch/x86/include/asm/shared/msr.h
+++ b/arch/x86/include/asm/shared/msr.h
@@ -13,7 +13,7 @@ struct msr {
 };
 
 /*
- * The kernel proper already defines rdmsr()/wrmsr(), but they are not for the
+ * The kernel proper already defines rdmsrq()/wrmsrq(), but they are not for the
  * boot kernel since they rely on tracepoint/exception handling infrastructure
  * that's not available here.
  */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 7228fc2bb43e..0c10b1f35270 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -36,7 +36,7 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
 	 * features that can be turned off.  Ignore the allowed-0 settings,
 	 * if a feature can be turned on then it's supported.
 	 *
-	 * Use raw rdmsr() for primary processor controls and pin controls MSRs
+	 * Use raw rdmsrq() for primary processor controls and pin controls MSRs
 	 * as they exist on any CPU that supports VMX, i.e. we want the WARN if
 	 * the RDMSR faults.
 	 */
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 96d57fe12de6..83bad446ecc2 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -67,7 +67,7 @@ enum coretemp_attr_index {
  * @last_updated: The time when the current temperature value was updated
  *		earlier (in jiffies).
  * @cpu_core_id: The CPU Core from which temperature values should be read
- *		This value is passed as "id" field to rdmsr/wrmsr functions.
+ *		This value is passed as "id" field to rdmsrq/wrmsrq functions.
  * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
  *		from where the temperature values should be read.
  * @attr_size:  Number of sysfs attributes in this temperature data group.
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 6320a0e45d38..74041a3410c3 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -110,8 +110,9 @@ static void auth_err_message(struct device *dev, u32 err_code)
 /*
  * To copy scan hashes and authenticate test chunks, the initiating cpu must point
  * to the EDX:EAX to the test image in linear address.
- * Run wrmsr(MSR_COPY_SCAN_HASHES) for scan hash copy and run wrmsr(MSR_AUTHENTICATE_AND_COPY_CHUNK)
- * for scan hash copy and test chunk authentication.
+ * Run wrmsrq(MSR_COPY_SCAN_HASHES) for scan hash copy and run
+ * wrmsrq(MSR_AUTHENTICATE_AND_COPY_CHUNK) for scan hash copy and test chunk
+ * authentication.
  */
 static void copy_hashes_authenticate_chunks(struct work_struct *work)
 {
-- 
2.56.0

