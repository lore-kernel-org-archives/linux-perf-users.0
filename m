Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B419CC36;
	Thu,  7 Nov 2024 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970354; cv=fail; b=Wzd9EA2js3fKjz9LE/XGdPl/aq1mZDX3ub5rGLkujGCtiHg0PDagJ0g+4u3YeebLmpi46eZ2m36Js4HI2A8hZC78psEvTfzMvCRkvOlhgM1aBzRFGllrWMQmskslhCgBIXBnFpfnXhuKg5zyJYr3ge3/jE7f3YgnWbF566e/8og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970354; c=relaxed/simple;
	bh=LU8N4dcDJAULToPN2/8UjQijjmxNHyktx1LfIa1yf0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cfqfbhwx3pBmxDQju6GMRu7qIR397g2Ab5LI8PZtN1mfL31NkvgMeKH7fvXpKZgd0CwyuskdaRx0MTtDOScsx/I8k/SwlDkWDQ7gnu50qcUol07EIdoRSm21aB4KmsiqdEjE8LgaiHiIkuXQVU8eEWbsVpHabRpdxuDe+BXxu/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eaj7+m4J; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eaj7+m4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXr2YD+YN+3j+ky7reUQJpZ66Qy2YebqGD276Q6U0XXQrp767nQJrL71D0kV4vc3tYXpbWv3N2rvtB0rM0EbDnvWjZpXNwUfG81mC7Hxj1+H0F0eOSehpvm2Qrd89Lyl1qKBPDAm+3eXoBYpP5aw92yf0jmupR/z9+3P+EQO2YivEfOSwEq+MQTqrmYZA25p5Iklx8FRGXU3hmClExdU7uGjuoR546VZPaMCkmG7isE2VJckik8Z1UtYOHsk/9OyOQgCn9oSOPRrFE93xSHWb8PqcHikCAL0up2smVF8vbtzvsmDiWVKkwpQFEY9iLkxCKZn0RI10PMJmEE0CmstmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6yjQQdXEObt/4wSmn5s2D8oUUKUim4MuDwZ9UkzvL8=;
 b=Lg4KnU7zOmYvfJ2oNavMegOWnvfvbbv+VtGEvgRtZMoZo5x8AOjFVitpEJtNeBJap69EYUzwBH4h6k+Dh9wmX9VonenbS09ZKvMHS/TGxwETfybfXNwv5x2p6TWUagrODafmJu/ObtCbyTCBjqyu69oL2NHUg13rWVr85om3LB8wfMHWjT2zp3Y6FtzFY8Y3ro8EZZZuccjvU/atrvvDlblLRe0TV68yXx/cxedmOXD550j8+/3nTsAEMCI+TZ+a/IxQpRlHUT3i6dRwMn1dJrwUdiyedxD2CYrIroSTVPbbLpUY5xE0uv9Yw9CG9E9Jfx3Oa9CDYXA3tlgAV8rJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6yjQQdXEObt/4wSmn5s2D8oUUKUim4MuDwZ9UkzvL8=;
 b=Eaj7+m4Jmo1vEmLiTcjuNdCRb/QM4pBPPhvKGfRkeyIcBeemJVzTucYR5cm8o7M4nL8S3ui+jm7X9pVN5u9zC94WswJwPmihm60LsBPU7Mj7n7wvtk/BMufPyxnvIjYS0gvpBbNjfVkPM76VjVMgzhm2uvhg0wGWan6nPr2l3zVrO6N19cvne+YJL/546ZqIq2IdRcUzhj+4A/XriqszAAEIU7Jwf3p3IZKvyiUbHFwRPuyb8HGMMNPvA4UdkDOCkP9rGhxhBr9dc8fDvqYSX8CwzKtM1W7t3Zo2GMbV/eiFR1shCgW8SQLpmi/94phZGHx/3BE2sUqANN1IIzrVng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 09:05:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 09:05:48 +0000
Date: Thu, 7 Nov 2024 17:03:30 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 0/7] Refactor cpuid and metric table lookup code
Message-ID: <20241107082807.ipb7xzqvs24tto2e@hippo>
References: <20241107071600.9082-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107071600.9082-1-irogers@google.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: a21a1add-ff2d-49d4-480a-08dcff0b5f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0g2N2l5MHd5SGZDZzhCcStpaldWN0JnSTMvRU1NMVAySG9sQ2F2aDFyYWdR?=
 =?utf-8?B?MlVNQWFIa09LWElxU1laR2tlQjV2VjExRzFUSVFwaCt3N3BRemtaaEIySURv?=
 =?utf-8?B?dDhLRE5kb3dxMDRkVjdFSk5hdTNBUnd4R1ZUMG9CbTZET1d3WXE5WmJMK04z?=
 =?utf-8?B?VjlhdkdiOWYxNGdmZDZmSmpjcXJFbk5aM2RFTElMaUY0UXhkV1FBeHhKMndZ?=
 =?utf-8?B?VFVCSmJzSzJWa1JWWng1NUhzUDFEdDA3eTYzWWdtMTZ1ZG0rc1MxWjVEak13?=
 =?utf-8?B?aFlnTE5pcGFMNzAxTmNtU3VpT2ttU2puQlZEdG1PcWZSRnplS2hLRU5UMzli?=
 =?utf-8?B?c0VzYVlONlZhbXFiOHo4SlAvcDNhZElrZUtRL1F2eEk3Nktqdnd0b041UzhJ?=
 =?utf-8?B?ZUduMFI5M0ZXT0NsSDhLL0VJbHVFYVpJSDBqeCtzOG8xUmJWRzE0enFvR1pR?=
 =?utf-8?B?TURtZkNEK3Ixa3VMU0pEUG5HUjdFQ1JzRlZndFYyRHl3QThpL1RneDljaTZD?=
 =?utf-8?B?UFIrY3k4MkdpckpmQVN5SDlSQW1JQXE1ekV2RDNURjcyUHo5MXV3ZVU0Ujhk?=
 =?utf-8?B?anNML2V3cytocVRoeGJraC9uN21jSUVaYlNrUEtxQ0JTVHF2UmFHV1dCN3Ny?=
 =?utf-8?B?cStTMEo3TmhiUTF4N3d1UjN3aTZTQld5VjAyOGR2eVZ0elN6NmZ2elg4c3U3?=
 =?utf-8?B?QjBZWW1pN3pYeEg4QWwxUC95MjRQSCtiV0ltdUgxMnY3QUs2cEZDY0dKMEZh?=
 =?utf-8?B?YnZzWHJPelQ4R0lWWUIxbHJiL0FsbG5NTHZJT1lEa1R6V3FOWVY4MUVtS1d3?=
 =?utf-8?B?cVhvZ0V1OENzVHJyY2YySzF6MEZueFdJN3ROYzVZZ3VhYzd6ckMzOFNWdURI?=
 =?utf-8?B?OHdlZEcxMTRpeWZ6UitYc3VyYk41anRuSGJPVWlqWEVrbmphSjN0YnJlS0w5?=
 =?utf-8?B?cnhjOEJoMGZQc1E1OVNZbUdSY3BpQWdocGppdXRpckFxOWtGdEZ3V0xjUlN2?=
 =?utf-8?B?azVLQkY2VDNDQm14TFNWTU85RlpReHJmZWtKSmliOHBZajJOekhiOXo5YkF6?=
 =?utf-8?B?MVZya0pqbG9MZFY2RDlmSE92ODcwdUlyZ3prRDhyanhBZ0tyYlVpQzFDSlNE?=
 =?utf-8?B?VmZwWGhsU3Vmb0V3TCtsUkdKVXpjQU9uQzc5SXVuVkVjbmIxUUFOOWlJR0ph?=
 =?utf-8?B?Q2NSNDRnTjlXOHdxVUpranNFVE5tU2pmRzV0NEY0STBIdHg3cGVUdm5IMWY0?=
 =?utf-8?B?ZGt0OVRMQmNFTjVGa2M3NWVnVjFJY1h6RDlUUzdFM3kvVnhPRXdsMng5QVRR?=
 =?utf-8?B?ZE5Fa1k0STVkQk53dk1XMzhnOHQvejVRYktmZGg0VmNZZFpOMEl4bHB3eFQz?=
 =?utf-8?B?dEE3N0d6bkk5MG1nRGllOXBrbzZVNHBROWtuYThTQWY3ejFJV1VodjNmVTNq?=
 =?utf-8?B?YlRlS3hLNzhNTDZpOVIzU2xCdjdEVFJ0bHk0dmZ1SGRiK1FGSk9FN1JWaGlx?=
 =?utf-8?B?NG5qR1ZnUVorZ0x5bmo4Z1hKNkVxTTU4MWJoWUtqbmVQdUtXc05ORWJYaTlt?=
 =?utf-8?B?SE5nYTJDd0lEeFFhSTErcnNNSFdCSHBHUEVxZXBQMWVrczNmT0VLL3UrQVR4?=
 =?utf-8?B?YS80ZStSSWdlRFhFS0ZBY2JmVzBuUWQweXBGV1QvVmd6OGJZRERSeVY2eFJ4?=
 =?utf-8?B?aHVMMWwwNERmZnpSb2FaaEs2RzVIUlAxbkhQN1UzeTJZazZsQ08rZmVKVW9n?=
 =?utf-8?B?R0VsTFB1MnY2d3BUMWlPR1FOSy9FWGhPN0pYNTZac2lidDF0d21tTE5mcWdk?=
 =?utf-8?B?WGhzVXk5dDZ4YStJTWNhUlVqUDZybVg2b3ZDTGNNbDJjUitBbTNtMG85eWQ3?=
 =?utf-8?Q?R3ytQkE09WGQe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZlZUo1K1d0VGRjcmY2YzZLNnJXd0V5TjgyL2dId0xsTkRSTFkvZG1Bbm9H?=
 =?utf-8?B?Yi95TzFUcDllNkVKZTBGcnVLb281V3M1d0lQdks3V0k1OUhQbFVYMHJqYXZS?=
 =?utf-8?B?YVBjbG0vNmhEei9Qd3J2OE1RSm9tTHFXY2JWUERpSWVXdXV0VjNWaWlZcVl3?=
 =?utf-8?B?bis5eWhjYXRyUjRQb3M0RXBQbnRqTHFDMldzbHZQdW54NDVFWUdoOWpNVTU3?=
 =?utf-8?B?aUdjT2pkTzFpOWV6bkhVZVFhMTdiTDJmTi8zd1pZSjFxZ2xBSlJlaW9CMmVS?=
 =?utf-8?B?bkcxWUNVTlFwV0x6YXMwQzlDSFM2aWxUcXhsenYxbWUyOEE2akZiUVpaM2tZ?=
 =?utf-8?B?eWJwSzFlR3diZk5JVjBaVENObHpUZFFXZjNpaUgyWnY0bHByVDNYcFM1Tk1a?=
 =?utf-8?B?ZEUwUGQ5dnBVakoyWFg4bVBJQ0YybVRyYXpNY2FUVGJFVVdjYWZyOXlPMVNT?=
 =?utf-8?B?L3U0c1k0K0cyY3A4WkxtTFEwNmYwZFdaYWtLdGtFdCszYzhrZ0dOZERWeFhY?=
 =?utf-8?B?TW8xNDl4N2EwbDlJN3IyaHpBTWlLSUVIV3RvbmJLenNlRzJ6dkZRd09Zbks5?=
 =?utf-8?B?OGdJbHloR0VmaXJtNFVVU21OY0M3cWRja1lXS2ZoMzErRTNOWXF2ZzBTZ3dn?=
 =?utf-8?B?azNlS0J2TW5udFozZ0EwempVSnZhdE9ZeU5MNTg1dlZVUkNSR015VThuendK?=
 =?utf-8?B?L29HZUdJNUpnNVZNK2dBdmJ5RWkzTkhvbkFKaWJtdjRpcjdlVUtUTHNrc1lH?=
 =?utf-8?B?R3dtNEUwenFZWmd5TVJTS21PN2hqbTRJQnNWNUVDMTJtREhSREdleVE4QmVs?=
 =?utf-8?B?NjhTSDF2ZzUxNERBNzc1U2ZZdnhDdGdvZ2Vhb1JpOWwyV1Z3QStXS1lTUS90?=
 =?utf-8?B?bzRsSnI4dmZDZEZ0RjcrN1JvMDRiamdCdWJJWDNVdEVsemJhUEllaVZqY1Fv?=
 =?utf-8?B?K0JNMzNXVjNhZDlVMFlEU0FrbUFJMU1Qc3R4UTBPaFNVSCtIUHJ2eVZDeW5v?=
 =?utf-8?B?ejZXTlg5VkRoaWZFTmtTdjFOcXZCRlhCaE1COHFsTDZYQk5ZWVFtVHI5S2J4?=
 =?utf-8?B?Ri9NcmNVNWNWcmd4VEdhWSsrdlJSc3pjVEtDUjFMOEt5Tlp0SldZc0xrWHI5?=
 =?utf-8?B?ejdmb3hDNHI0U3N2TlBzNm03ZUI0TnFtakF0S2s4Y28zOEg2MFlURm9TdFYz?=
 =?utf-8?B?bVdCcTcrREdvUEtwWVF1OVNEaGJYL0FPNUJqeHROV3YrczlMdWNwdi9kdkpv?=
 =?utf-8?B?Z1lLSjNIRUxobFg1bDlDWmxqM1ZiUVhiVS9BNlNuNERubDg2bGg1Q2dLeXcr?=
 =?utf-8?B?ZFF2TktueDVOWXRCZzJrVTE3YWNRTENNdGZnQURXci9keTRsTTJYQ2d6d0pQ?=
 =?utf-8?B?dTRNV1prak43Sk9uT3gvWktiMDZrQU4yc0p2SzVPYTJIQ09UanlUV2NPMW1z?=
 =?utf-8?B?dktJTlByZlRzakE0bmRBWWVjTGNnU3dlSnlrRFJuVTE2MlpicTJrZnlSbHZK?=
 =?utf-8?B?M3BVenludUN3K2lHN1hFOGttWTMwbmpwVDZiam83UHppdDI0bTdDczB2YTZN?=
 =?utf-8?B?UDZLd0tXOWMrYTdCQ0xaeFNCMmRpTDE2M0lYOXhndGRyNmRUaHRhdFZBOVQw?=
 =?utf-8?B?NmllUFQ2OTFFcUtXWStsYkFlbkExb1dVek11cjQrcnpLSFlkOS9yR3dtMGEv?=
 =?utf-8?B?Y3paUTh4cTk0UmxvQ29SRUIxS1AydklVa0pYR1E4QVVJR1dPQlhROHJNUCsr?=
 =?utf-8?B?QnBGcGVNRkJZeXdIelBvUExlOWhvUStlTkYzNXAvUnltUnNSSjVBTWNZQnpR?=
 =?utf-8?B?VWo5TnlyUm50ekEvdC8zMng5ZE5ndUI4ajVQL2xBalNPMkhtYjVUYnFvR01s?=
 =?utf-8?B?VGhtVFVITHpkUGY5VDduZmx1TTExVDloNVNxUngwK2Q4ejArQVIzMkN3eVNJ?=
 =?utf-8?B?WDJBSHBnbEVkZWc1cXdtWnJJNThEUXVBQ1lxNEh0R2R0OS9sdUV0djBFMGFx?=
 =?utf-8?B?VkJnZDJpWU9iMk12UXdMMUZwdVpvN2RIYWFTVmhwYnZmd1FOQXZ6MVczNnEr?=
 =?utf-8?B?dUlEbGdGVFhMS2NDRisvMGVWa2ZUdTg1Ry9kOEwrekpnNzJkdnk5MEFGWCtS?=
 =?utf-8?Q?rz9LSGSRQD7UwZ4ii58D5xcrP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21a1add-ff2d-49d4-480a-08dcff0b5f12
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 09:05:48.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZalAjcX2Y5EbQ+BsiBpHGUeZ8ZPiJs/mVK3lIWzRAcwF0h+oNrjPQwucLC9a0XsySJF+HL6goB5UNVgdJkj8oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

Hi Ian Rogers,

On Wed, Nov 06, 2024 at 11:15:53PM -0800, Ian Rogers wrote:
> Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> lookup:
> https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> These patches remove a lot of the logic relating CPUIDs to PMUs so
> that the PMU isn't part of the question when finding a metric table.
> For time reasons, it doesn't go as far as allowing system metrics
> without a metric table as a metric table is needed for metrics to
> refer to other metrics, and the refactoring of that resolution is a
> hassle.
> 
> Ian Rogers (7):
>   perf header: Move is_cpu_online to numa bench
>   perf header: Refactor get_cpuid to take a CPU for ARM
>   perf arm64 header: Use cpu argument in get_cpuid
>   perf header: Avoid transitive PMU includes
>   perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
>   perf jevents: Add map_for_cpu
>   perf pmu: Move pmu_metrics_table__find and remove ARM override
> 
>  tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
>  tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
>  tools/perf/arch/arm64/util/pmu.c         | 20 ------
>  tools/perf/arch/loongarch/util/header.c  |  4 +-
>  tools/perf/arch/powerpc/util/header.c    |  4 +-
>  tools/perf/arch/riscv/util/header.c      |  4 +-
>  tools/perf/arch/s390/util/header.c       |  6 +-
>  tools/perf/arch/x86/util/auxtrace.c      |  3 +-
>  tools/perf/arch/x86/util/header.c        |  5 +-
>  tools/perf/bench/numa.c                  | 51 +++++++++++++++

Meet error when build perf tool:

  CC      util/levenshtein.o
  CC      tests/mem.o
  CC      util/mmap.o
bench/numa.c: In function ‘is_cpu_online’:
bench/numa.c:550:21: error: storage size of ‘statbuf’ isn’t known
  550 |         struct stat statbuf;
      |                     ^~~~~~~
bench/numa.c:554:13: error: implicit declaration of function ‘stat’; did you mean ‘strcat’? [-Werror=implicit-function-declaration]
  554 |         if (stat(buf, &statbuf) != 0)
      |             ^~~~
      |             strcat
bench/numa.c:578:13: error: implicit declaration of function ‘sysfs__read_str’ [-Werror=implicit-function-declaration]
  578 |         if (sysfs__read_str(buf, &str, &strlen) < 0)
      |             ^~~~~~~~~~~~~~~
bench/numa.c:550:21: error: unused variable ‘statbuf’ [-Werror=unused-variable]
  550 |         struct stat statbuf;
      |                     ^~~~~~~
  CC      tests/cpumap.o
  CC      tests/stat.o

After remove these errors, my issue is disappeared.

Thanks,
Xu Yang

>  tools/perf/builtin-kvm.c                 |  4 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
>  tools/perf/pmu-events/jevents.py         | 39 ++++++-----
>  tools/perf/pmu-events/pmu-events.h       |  2 +-
>  tools/perf/tests/expr.c                  |  5 +-
>  tools/perf/util/env.c                    |  4 +-
>  tools/perf/util/expr.c                   |  6 +-
>  tools/perf/util/header.c                 | 82 ++++++++----------------
>  tools/perf/util/header.h                 | 23 +++----
>  tools/perf/util/pmu.c                    | 25 --------
>  tools/perf/util/pmu.h                    |  2 -
>  tools/perf/util/probe-event.c            |  1 +
>  22 files changed, 187 insertions(+), 229 deletions(-)
> 
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
