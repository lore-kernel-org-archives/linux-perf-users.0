Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022137.outbound.protection.outlook.com [40.93.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6A19B5AA
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708187; cv=fail; b=BPeyyFb4nIMwbj2zwHzhkyyNHe7MYJEcPWF8aCQaIyA5kTQmgAxRnLivNPHhNX8kH4h/s+IwwStt1wSH3OQ7ARU4k0Q8+f5felGdkizcstQ5s5kaFqgw5R3RRmnubuWyzPaxN66ZE4X8l6gdV2o/JhBQ0PkPbCGmHXhvuwedVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708187; c=relaxed/simple;
	bh=Yctv7RByTfm14D1nh5Zq77fN/8Qr9ammdk9U4cmaCCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpvZBRnsdJfH7N3SaCJfiFzrFtkpiN32Wy6NJdBpvlLDR8TUWaZs0jvB9xDqts83w9VUUkBDbh1HqK5uXdjxu+iJj6+dHyxLQKV0a0jtWj9wKwaD45HD9Z/hp3EQbtW+aAx83hUs9rhd4rQZDQhP7dGgpnKok1Bpc0clhJOVNqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u3GcBaL+; arc=fail smtp.client-ip=40.93.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u3GcBaL+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGC8pfOTCOtABgrtWq4AEPRbLmjHWrPZwQvYZ4t+Io2kOtYgvBH87oyPw9NkF9seq3i2oSkh38csFrys8IaJFLhYgTw5/TrFhvzqzGGDQ2V2xhFc1sc4Laqtln92B3Z6rmfRkZPp7k4uXz3wwlgWoHC/+DKK5iRrTnyO1bQ4HNfdgbK77nr9KBoBP7B0zZIe9ncbBuCaQVJKc/us5CsoAGrbnFIcw3ZktLXeZWjONP7YMl9X3e1YPX7s+FzBZsFcUfZ+RX54MHIcuorhBt2f5XK2ZiwfGnRqHfi+IneLRWrpwx5gTqyBcmqXW/crlb2aycpnr3Bhq6JSxjWsC7PoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAERlNiW9pyPTkrb1TcDBDVT3AA+peDza7BurMjsD1M=;
 b=CUSN6slknln5Wwnji8LHc62GZLRsmrttAfGabWCN1zd6gPW11Xuw/PgLTmo+biiHNXGpPHAhhkg8PURYGUWYJ+JcSSF7k5H4Vx7GXLng3NIWuufBQAPndmxAvB7fJWNkOpiFfCfeTGdwjYOM3AdBm+34ysuCB3Re7ZULKI0UYhpJqvU2QbOPq4mpZ8tvqc5iTgogCYkubfPTlOK9b1ubZyjwgRPa95aXALYANUHoZ/LDyaiBVgxvIRhwkjCk2sYBslycfKM0g6ZbNHdHAu6gVdtAh1tNovuKphVxKrXwuFtxI0hF15C0dZv1Ka4ATccg0KX1xQbnQ81+qYry081rhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAERlNiW9pyPTkrb1TcDBDVT3AA+peDza7BurMjsD1M=;
 b=u3GcBaL+O7b1zJ0ZKdHx8UGlsA0U4JFw4kg7MVKxyyQLvNyZkm2dMof9I3bOLS3Vtmj3RL4/VEODkO2qYP8kSDZ4hddkrqaGUdjwZgR4HAuM4Zscl7zAoanF/GJUPzPJXICPsYO87sTRXlAyRdzVsNVJNz4WLJqvcrLiWwjWZhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:24 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:24 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 1/5] Add dso__is_pie call to identify ELF PIE
Date: Mon, 26 Aug 2024 15:35:56 -0600
Message-Id: <99684496008df1c7b5437a4c31277fa43df044cc.1724707494.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724707494.git.scclevenger@os.amperecomputing.com>
References: <cover.1724707494.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c60fced-262a-46a0-3a0b-08dcc617227e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJzX9sWmPfvRHx0PVweVkQgv7RP2wZ1/CqoU4m/Twbynv8VmMK1N79furnyK?=
 =?us-ascii?Q?WgHv36dzc3T6nHvQJ+8obgxJ3A+79EV/LhV1vmMvXvIK56II1le7L/wdZT2v?=
 =?us-ascii?Q?CZcgz5Qs8UR2aHIEaS1U2i/9nIEOrXPZHMcGctqX702fugBxcnNqxHtF/Htf?=
 =?us-ascii?Q?sooD0eqdTGLY3RZHfJ6EZAEKR/i8Rw3zQcM5P7Qxq7Oh1zy5mUqseN5L6jZX?=
 =?us-ascii?Q?NCyUFc74Ec/AKHbkOhnP0oVsvNdCRQQ8nwgGdD6uqCN93rqCCEIOYvZMQDqd?=
 =?us-ascii?Q?NjDRX3/Ph7F3D/mCuH4FTXu7m5rKbeFek5aqK6sby76CBKeg9iTJx/h+jZsS?=
 =?us-ascii?Q?m3atZKlvJsZK3ibC+63v/i/KKw+Sg7dOE1hjzXKqUU4QZr5mY7OmMaB8x12G?=
 =?us-ascii?Q?k0ZdTufNVwwkVdvteXaaANpKn4XnkZMkq6c5onRCW7EbpKvcJfp2/mzw3mMZ?=
 =?us-ascii?Q?sm++OHaX9kiqkwZY7ROcXIWjCSq98aq51wU6kishZKWha/DOneqbXRvi1WvG?=
 =?us-ascii?Q?PeV+4KRGw3/YmdHqyNaNOpPp8ONRgY5XTMdwBpSPltJexLaRpK5aTzBhLwz4?=
 =?us-ascii?Q?iPTGk0EabmbgF2ndkCc5y4aIhRfq80sDIiPnQ22X+g8/jxPTFcCeDAr4ZGPh?=
 =?us-ascii?Q?kCHBkPHs2yF9Uo1IoL2IL/ecwJ6I/yioyP3KJays84gJlVBw/48M8h5ZOsd5?=
 =?us-ascii?Q?TQnTFTD4YdI163ikak9tIGRgPXjKOQOhc0k2Sl9cM2Z0wEKZiUSTPFYvwQL5?=
 =?us-ascii?Q?9C9G5mWr7RdjEzHLZHzZl2BbNdtz27TszFmUcpoCooxLLs+Mvzb8yPfRr01h?=
 =?us-ascii?Q?xDyHqFFgojzcTTYBLr44Sb43JRyX/q6vO8g2DSGzrtdkn/+stmJGB8f20QEU?=
 =?us-ascii?Q?Nb/UNzVregJkfktsxdEgrd28BPZ2D8ylbywMSMNGP9NIp9qi1Hwr+1DOK5Ys?=
 =?us-ascii?Q?yPuofujLrfN69E1MsSIY6bkwWmXXszGgPKU2/yBZ+2vCOnxkwjkcoqHFgDPI?=
 =?us-ascii?Q?DT+MLnbxyA4ED4cP6q/R2qjqO51o6z/Ac6+45XDps0rMohAj3BUnlt+VfVgH?=
 =?us-ascii?Q?5gAVBJx/4KinUrA91zLMMlU/xVuQR/64gh8P91R9qHcbz25tD72vUVp36zRr?=
 =?us-ascii?Q?KeB55c4DYnnljtQTkQs7Fe/K1QfRSgELO8wTTVr++JCagM1JWdpzC1zdQz7C?=
 =?us-ascii?Q?9EwjRDFHNkZaIB5wcGzVc+Da8V2WBylfeO5AaJxEDLq6XeXsgoY/SZaqrJw3?=
 =?us-ascii?Q?Qme17K2OpSZyJSw1AKJ0Bavm1qw1QAIm2Wo2pvP4vZ+B1ga5NfpDpwyv4Y6r?=
 =?us-ascii?Q?hzTnoI6IOqZJ0VYn0hfB50M5NcPCanBw5tVJdePLfTRtaH+xGBZKPjdiK4bm?=
 =?us-ascii?Q?kn0p6sQxqQW+6qHscNqssA/ezi+vU1h2B3ndQBUP3LtChXiJVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNFZwQgeDBjkdz95dCkZFFWIQTn9by/eTd4PzLu3ce/MRSZjDWwabwaN+K3l?=
 =?us-ascii?Q?WG03uNNZ4jE6L3w2VE7cxZgeKbeDqzuSojKDlL0wjVEdVdCyVhkiICEL7zvO?=
 =?us-ascii?Q?B428qzvsVSHPzhhH5uvzqehegAhdmnJA7aR8azh64zr6gAz/fEpyvawO6XDd?=
 =?us-ascii?Q?gZ4zLLzVJnH3MizweiHAZeZ3s8Fo0U1JIdepj5hn3JYRbU71uix0AIEHqBNm?=
 =?us-ascii?Q?m6qbyeN8xJ8tjl5G1TLKpM334ZG6+PmuvPluplH4gE9vHrmgG/c9dV4tJMY9?=
 =?us-ascii?Q?/G4rVG44nilRKzCfTgmpzQiHlcmlM0Id7+G8NdW0p/pCg5M8gBk5P11/a6cz?=
 =?us-ascii?Q?ozCFr/uobX3NBTgt4ZKexbYovjPcm4yXqRerdXS/nzUMMgN6KpmcScP9Bl3I?=
 =?us-ascii?Q?MGO9g30eeSLicvLNfRUBN4kiD4n2ITmuXGTAvTipftTcDZH5FBBq6W3KaF4p?=
 =?us-ascii?Q?4iTP87n+0AT8Xf7uYg/YPguS8FWRQHGpGvl2VuRs4L1B8yciyW5lyvhoHXTi?=
 =?us-ascii?Q?rtxrXjVefy7DuDhiM9Ia9dQdpt5s+vZocEA4a/SkAdDxHofnZ/RQA06QUm7C?=
 =?us-ascii?Q?Kes1o/bgaNUgwmUMVWqwPcOVuSCiL7VioVuJAiFjhjZFvcnmfiTas90QPruY?=
 =?us-ascii?Q?9/8sZfc/XRiNDBn/Fik2gKAPI1K5noG6avAFUwzCuAqh7XKlH7dcZ1EbiXmm?=
 =?us-ascii?Q?gP6HrMz6RI8xgjueRqhMnUJXFnkk009dmRt2MV0OxEmcqi68EuJCDwQ1ZJHb?=
 =?us-ascii?Q?5/0TRy5PT1xrAQKDbtqd7qCPvFXJy+rXcZsL253g66/6EUH6qyhyptnCKPdI?=
 =?us-ascii?Q?GlyFGXL7YwHfZ4rPFBZ9sFa8zRBdm3XGKwRMXz7ErGyi0bLQ6lwxH0g2PsJU?=
 =?us-ascii?Q?sfgQ5/SWfg+j/eeEb3HcVGLJwZZRukTAdbsuj+aRTzOwKCTYXUWMmO7q38e2?=
 =?us-ascii?Q?oo+1ai1olLOk+4QHmTKAZJOBlLpUCmZxH+jGPxRqFh2311IEWOxUJpX73S9r?=
 =?us-ascii?Q?FruSJECFY578cTpylJIi9sZ7Y5Ku6sL6Y5Mt04M2aBf6W4MKyjJa++XKyAuD?=
 =?us-ascii?Q?ZO/JdkKp4U+m+ZIuJFqQEo9FsGmxlDPS2vEsBAdu1aPvg3L4qK4nDi/yivx/?=
 =?us-ascii?Q?4eF2gjo0QeSVlbje0BY02OdUf5Xl5OFKSrExiUjvvPDYlR/Rt5+qmniC4uWF?=
 =?us-ascii?Q?OYfvGrq2lDi45y2Va11JixehSEXWqVyddCyRQCuytgFoAULkqTIrEZjO4fMf?=
 =?us-ascii?Q?gM6SOz9ITz/y8e1bPVJ5k7AlIBWWL88SJlex0iw0L7e9sNfI81IBgJylcgqJ?=
 =?us-ascii?Q?xrCYHstrvmndvxxm/mtTCcMDAnMKxm/lsAaa0QT3f8MbFhTPvPFvfdkspVRO?=
 =?us-ascii?Q?3S1Fp5BxP44oF4F2XAkyHMncD0mMPzSjFiZ/iZ6QY9zuWJsACXf3YZjjv/4d?=
 =?us-ascii?Q?s66TRIw5uOq/iiariGUGmZ2xenzcA8WHDTUUzIbfyS+Dxnn23bUmPi0un/m+?=
 =?us-ascii?Q?d+2L3SAL2ugR/3j5LX5Z4SITF1xJNc+UA0o75xR7rGC7OnlWetjFEVlbEqFv?=
 =?us-ascii?Q?JW1ZGxnxCCFy3ltbDApKC4KVqdFmeelwksrl+fEb/X4VkHA1i4WYCEE3xyom?=
 =?us-ascii?Q?gf8FgrTVmGXNawV4vvew2gZn26v5FIDEExMukg6+Vn3B?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c60fced-262a-46a0-3a0b-08dcc617227e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:24.6013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GY+DjwMEb3xRZetddoQnBeTpYwCXYhteMheZdpDNiWKHUmBvSJgPyzw9tls5ior7h/JQDAvP0crMDz+rUPBnskirldIRdE7i84ctKjTPjbtIMU9/Ir//hT1q8tRhjneG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution
  - Decrease indentation, add null pointer checks per Leo Yan review

Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
the DF_1_PIE flag. This identifies position executable code.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/symbol-elf.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index e398abfd13a0..0e49c1345a67 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -662,6 +662,66 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
 	return err;
 }
 
+/*
+ * Check dynamic section DT_FLAGS_1 for a Position Independent
+ * Executable (PIE).
+ */
+bool dso__is_pie(struct dso *dso)
+{
+	Elf *elf = NULL;
+	Elf_Scn *scn = NULL;
+	GElf_Ehdr ehdr;
+	GElf_Shdr shdr;
+	bool is_pie = false;
+	char dso_path[PATH_MAX];
+	int fd = -1;
+
+	if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
+		goto exit;	// false
+
+	dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
+
+	fd = open(dso_path, O_RDONLY);
+
+	if (fd < 0) {
+		pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
+		goto exit;	// false
+	}
+
+	elf = elf_begin(fd, ELF_C_READ, NULL);
+	gelf_getehdr(elf, &ehdr);
+
+	if (ehdr.e_type == ET_DYN) {
+		Elf_Data *data;
+		GElf_Dyn *entry;
+		int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
+
+		scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
+		if (!scn)
+			goto exit;	// false
+
+		data = (Elf_Data *) elf_getdata(scn, NULL);
+		if (!data || !data->d_buf)
+			goto exit;	// false
+
+		// check DT_FLAGS_1
+		for (int i = 0; i < n_entries; i++) {
+			entry = ((GElf_Dyn *) data->d_buf) + i;
+			if (entry->d_tag == DT_FLAGS_1) {
+				if ((entry->d_un.d_val & DF_1_PIE) != 0) {
+					is_pie = true;
+					break;
+				}
+			}
+		} // end for
+	}
+
+	elf_end(elf);
+	close(fd);
+exit:
+	return is_pie;
+}
+
 /*
  * We need to check if we have a .dynsym, so that we can handle the
  * .plt, synthesizing its symbols, that aren't on the symtabs (be it
-- 
2.25.1

