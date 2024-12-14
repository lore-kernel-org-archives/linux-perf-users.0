Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022118.outbound.protection.outlook.com [52.101.96.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A3195B37;
	Sat, 14 Dec 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734204901; cv=fail; b=tjaB+gLMt06xvj9MLWMR3F5FIEsoM8vnCiD0yUHXUIXz1IkTSizccfXGqjKeWqo/67rNc3w3wlCc+XWsSQU8c4BlK4WLld+Bbyau1PwquCff9AxOmW0kcd1A3G3jgwAxncNXcnWkT2Zex7Z5n0ixiOowQSfsu42yw2xuOK6Hi2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734204901; c=relaxed/simple;
	bh=x8cwg7dOYCyCslJJR88RF7a7oACP7UonzFFzS4HMjis=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sNq0YSBTbReNX6YB0Zir2yTIvhRW6k9U2GN93gUPevzvYyoG/QRPwLrdNiN2h7O7RlV+mYReX9vFw1iOXGrK6z+pcFgYjl7R+wHVDQzLLyeO0eiEyl4sVaQ6g6ahqoNgKo59gsTsNieo9soJxVHAyGN+CC1UbgkhpXuhqW1JVJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOP+L77JiMBqQXi8ucpv12gplYx0KIdIZLoGH/3UHRUf+Gclyb5xsGr/PEPmDXLgHPchWIZhemDnrC+C5WZJhQBERng++poxJ3hQ3npOX+n6B/yr2qs/e4KjFbea6ASHSzdpDA2NFSUENW7sewiHavfAzw1SEJaHViLzbGmQyxTR8Xu6CR+5NS6M5zcqD12dcq9f45YMkHaj75YMfK33w+Gc/6n+xFxijTlcxqcysgg6IM0NEtsdl8RY76zACqECM852qgePyg8f0pM7n4vK8wnYc56Hy+u08G02KHNDijJdq2jbPzjrckSlb/yBDLv/UHYIeqrzzeiSHsm3qC4auQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPqjruM200yogGX4nfdtsr/ciNwhcSPubkS9XZNfHp0=;
 b=HDSdgeYWOLfHKkn5n8+PprDDp1gdyOsBzvngOPMDr1aoakp0GPpqq+xrNSxRNzemlkZiuhMt0SwguYtyzQAcME8s+vv7Bg623V5df6ydBfobfW65SK6HEaoZZ0zU8Ii/KMeE1rjZYyfpvF0Ki7CJuBXGCWMFybPZA3P/Op5+wha9ywL7LxwDffsqlMr50kwvlLtHrgJPDCeSPQGAhHBac+WlyMF5AHRCsyUtDYYlqqroG/AmEQ08epvZcybeTYqmVLtXWWbAroRoPOZ3AIesiaQsLIVqZ+uqdS0K9mNk9ydgc3voOV5ZNlGJKoRt3MHnUa8qB4S29F9/iqw9h0tXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6392.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 19:34:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%7]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 19:34:55 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	atomlin@atomlin.com
Subject: [PATCH] perf probe: Introduce --no-advice option when a new event is created
Date: Sat, 14 Dec 2024 19:34:52 +0000
Message-ID: <20241214193452.16627-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 485130d2-c797-4190-9ed1-08dd1c76627b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJpsNL1Yo/XgqOcHLzlrZ8uscLsRC0JHjCaAMgBYRcQZeCIFoVns/MIkV41v?=
 =?us-ascii?Q?Vqo4eM0vjWfCptUPB5FTIdHEYfXkJlvuR3yi6TveI5+Jq7PksWzeelVAkJSv?=
 =?us-ascii?Q?Nlg9hskmQjvOokJmUBIvH5HoE/LSqLFfNGBt9HEspWo4QLMFp+7zXrYpgtNR?=
 =?us-ascii?Q?Iesg/WrJm6+5Xq2rb0StY/GozukWebhLosnrgf17n6gA+7uExSLnV7+vXofZ?=
 =?us-ascii?Q?FJiJ7dDdtG2c6AeadtkqF515yydZr2sVa+rKP4/kkUynArrtlnTTJDqmW1LA?=
 =?us-ascii?Q?/q2Ci6bi94spn83hfu4U/XLLvYx3TSE+8Bp8DbAIf1n7RgTCvl7pAjB5WW0R?=
 =?us-ascii?Q?E0E9aVXm1ntw2U2WFIhxiHcgdgjZWNzrHVyg9ELdzp0BDwzTkABQ4uGa0D/H?=
 =?us-ascii?Q?18+7XDg7nJcZXHBqalKc15/+eETIP/EIEAN7z/OM//VylVVG/qAUZCXp5cVW?=
 =?us-ascii?Q?UDE2Zt/DekJdElkfIfWOPzXOBnCb/qAC6N5FrORgt/WwZapJ3+De+9XRNmnA?=
 =?us-ascii?Q?DIDE8XDwk7ra8AQ4CU3CCkj0rjPvqqB9/e963kitmbm9sIVPn+bCFofejLp2?=
 =?us-ascii?Q?7FU5BzstaE6nHpmIfY+KIVm2iHojoTuusHWGUodyIxhbvJMv8noZjKJK61iI?=
 =?us-ascii?Q?V4VnDVRnj9GGMIxc7nuf3Obl9QjwKGiUVeChTWKlPLzqEBrINtkGFt0U8mqZ?=
 =?us-ascii?Q?p0WKtWTAjOZmJwMGjbHdus1L2WDqMLzpJY0I8/LogMGTCqX2YYpTPmocm8co?=
 =?us-ascii?Q?EJXFSruHaU7foi1VebmSopswTidXNvC8KFxA/WMw/OamMeK6TwkBKvtd7KER?=
 =?us-ascii?Q?Vsd/pV8/G/d9qw5LPBFiyvtbiZNRah4gzsn4EbCwdu6rBYyEJ8vk4wjb0txs?=
 =?us-ascii?Q?AparDKFhKPy7aNJWxCHCXjuAAfsjTKP1Fu+iSBa8TpKFZsXPysBLKbh1Jmhl?=
 =?us-ascii?Q?K9Q3CHT4PbUI4FCCiQOGCYDZFSk0aDA24PfYJ5R0abQo0jVo6t49OT/VjE4M?=
 =?us-ascii?Q?iSsOzKpG6GMwi/iFhCj2975HJQKbIOqUlppjxCypidLDj2TOM0Qw9UblWtLk?=
 =?us-ascii?Q?ylYYPHbp6vURAnIac2/hjW7C79+ZBLuRRAX3ThYYNPetUW8QQQ8UY+syh6dn?=
 =?us-ascii?Q?yBk9DGYujLC8d76rnUMQApRaN5le7FPqWuxs02sPUlYfhkyCxxB3vzEuq7QR?=
 =?us-ascii?Q?c0pIFeJiqv1KWMCpoLOIOorKbLiHSKfkbVVeh/JyaxQ63dLkSI9LACrrOT1X?=
 =?us-ascii?Q?fUVtu8GfEyCSl9hf0QFhfdeYJFanQW0O+XNuvjTOmkRkj3yjGcLm5peoKII8?=
 =?us-ascii?Q?ZdBK2wcze7RYE2vlp6ZwZ3DbT4PQ4Vm89lHb8dswdRhtuY/zpZTDykah7FWI?=
 =?us-ascii?Q?wXVFlMSpIkv2ur3z8y/wcj/M1p9y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tFrxhrUlVt1lpGgstMInnwLAMT0BtmCWxe+L9WVFA3TYTkc0hn3X5XEtlqd5?=
 =?us-ascii?Q?Yk3jNhZ6dLQp1MCrn4VJUmTEKDq0VuNbPs5zr1fBBZMkaEGcmS0Z/iw17GQb?=
 =?us-ascii?Q?HLy8V67rpqDYip2sn2jiv29Z1EqV0KMM8KExzfLoUST8DvrumzUweBdUQHEz?=
 =?us-ascii?Q?xgwrOBMggCIsHMKagjy4ByX+J8qWYkimVUREORHHFTh7NkQ9ZkLBrbh+i56a?=
 =?us-ascii?Q?KK+hBL6XdbUCUFytTN5C4T2QgTMpBNr8S2BUzr0Wt82/BbAy6M0MVyJhuwey?=
 =?us-ascii?Q?O7eZ7xxb3AgN8HVzNZICV0ZK6MTG6Gk1RpAUWtSq60yTkA7vnJNyW3OPNODY?=
 =?us-ascii?Q?POkhPFYjexA5HnHnOP7q5vF5Jst9ZUG31YeJeeBfxdbhNcfT6vqAL9F3THlr?=
 =?us-ascii?Q?wktZJ/ff+6HK1+YOfUHiax7XGpS3FUrOYQDmfUtlKct8oxmch1yGxVC8fycN?=
 =?us-ascii?Q?1n/VSRnw7V7Y/cqzlQVFqWaCsn2x/GCW6K+epHDKNFBrewpYBHZxtN5YyX0T?=
 =?us-ascii?Q?tAv4Cs5scMTmYpyye1snNpGfIj+8MLAqQq0imR25q36Uvm573hFP48fRxw3g?=
 =?us-ascii?Q?5NaHSOZ8NUXHXjVEQyQkHe03ynnTXn2rXgBIcj10JABEp7WUUtqwGSx7DH1J?=
 =?us-ascii?Q?Oo7HV9LySiS3VwdjHXyo3mSwyGDzjPEQpZRSWE9Dk/IUqiahzZjxmzeQ+yn2?=
 =?us-ascii?Q?k1sMUuMZ2RjDr6z2Kmkbu1yPVnidailXBTpwmaGOQOFB8TqBz3jYmm4+esnP?=
 =?us-ascii?Q?NxsKtWKeBNiSOS+M6vMNN1p1jHRqfJd6jXW3K6NTRqXUI1cZBlZ8tDKqDTFO?=
 =?us-ascii?Q?0Y+Vaa2ePt8xApI1F/WMNVWj9WgIhGKJ/CO4mn0f0nm4fY/NjwqAfOKzr9SF?=
 =?us-ascii?Q?sfylf9oAv4zXmV87+yGbQsIr9pbmXERSgTw1I2buMuAfRULDB8kzhtrAIEMl?=
 =?us-ascii?Q?3x6OqVcIIopEga9+LBvTd+MvmmyTfgJSZXBG8JK9hMZx3C6Hk9g4ZBnUXdSR?=
 =?us-ascii?Q?yYU7iakP4AEzHGm0VXhhTqtw+H1rwDyxxQBbJd4N0rZitmnAPJJjzo8whkpl?=
 =?us-ascii?Q?C6yThCtSXe0fER9zKkTK3dxQKTLrLcjiqL1erWOLM6/OEz9cstBGBY6F/QR9?=
 =?us-ascii?Q?DwhnQ9Qv+sbYgxwD0E4dYUaccoVZnJeIuTu5Kvdc2aSZrSsTRuhlE+mWs01j?=
 =?us-ascii?Q?6R7s2yWvxk30NlG7ucAOnYa3P46+mu89LBy3kK3KNq9cLFfPpHZ85m1W9EE3?=
 =?us-ascii?Q?GUZQ94ydbL9lPafFaDjAJa9vGle8EbwtrXKi4ZtHLLlBYv0aJ8aprrpAS6Vw?=
 =?us-ascii?Q?ZGE6+4UJDXPruPuRHDAbUE9Sve+kqa9E/AIOkLCiENRX9BK3sWJiShDqZVjk?=
 =?us-ascii?Q?6S49UxGc8dzbAfJl8AJzv44vO1HOdL1K+SvM6uMeod2Jm/QHnfAv6mSKMZts?=
 =?us-ascii?Q?RzaOrDEQxVoQZxTaYjc9/5YBs4gZsQGO6gy7NYqgPjCII0Dlrv0+juBYMz2p?=
 =?us-ascii?Q?zvbt1uAzv3BN3nSaQU7MbRUJWS22xyphF5kqFRF7uyoz+o7A088QfrcItMBF?=
 =?us-ascii?Q?8v2Cpxm79qUavJf3OTqKnrFcU5ccIWHvQIXNCLvn?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485130d2-c797-4190-9ed1-08dd1c76627b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 19:34:54.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slRa8ofywy2nKm2Phn+L3wJ3KPhUpy7nyYhPUhKYjuar3grpvXgPb2GFMGrobmPWZZ+RhQuzCWpHHfLNX35cDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6392

This patch introduces a new option namely "--no-advice" to be used with
the add command. Now one has the ability to avoid the generation of any
advice when a new event is created. Thus making the output reasonable.
For example:

  # perf probe --no-advice --add 'user_path_at%return return=$retval:s32'
  Added new event:
    probe:user_path_at__return (on user_path_at%return with return=$retval:s32)
  #

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-probe.c    | 4 +++-
 tools/perf/util/probe-event.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 69800e4d9530..36b8e08f3725 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -391,7 +391,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 
 	/* Note that it is possible to skip all events because of blacklist */
-	if (event) {
+	if (event && !probe_conf.no_advice) {
 #ifndef HAVE_LIBTRACEEVENT
 		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
 		pr_info("\tcd /sys/kernel/tracing/\n");
@@ -577,6 +577,8 @@ __cmd_probe(int argc, const char **argv)
 		   "directory", "path to kernel source"),
 	OPT_BOOLEAN('\0', "no-inlines", &probe_conf.no_inlines,
 		"Don't search inlined functions"),
+	OPT_BOOLEAN('\0', "no-advice", &probe_conf.no_advice,
+		"Don't provide any advice after a new event is created."),
 	OPT__DRY_RUN(&probe_event_dry_run),
 	OPT_INTEGER('\0', "max-probes", &probe_conf.max_probes,
 		 "Set how many probe points can be found for a probe."),
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 61a5f4ff4e9c..be0dce26e133 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -14,6 +14,7 @@ struct probe_conf {
 	bool	show_location_range;
 	bool	force_add;
 	bool	no_inlines;
+	bool	no_advice;
 	bool	cache;
 	bool	bootconfig;
 	int	max_probes;
-- 
2.47.1

