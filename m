Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755C2D5A0C;
	Mon,  3 Nov 2025 21:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206540; cv=fail; b=EleOSYkJqFZEUnIffUPuFEFQIRvnTMjnuy7XI5JL20Efj7tD8hyM+VhesCVuCQMuJlhbt+iFEEEv9YweNP491YC/STAqCiBs0FH/HiMIGe1aGd2iBeqKf0NXTrUPsgqqOjpq/n0/Cr4sA0XsYEedrYhj8JjMA6w6rxKsaPwC+5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206540; c=relaxed/simple;
	bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b3TngDHBeig8asxPrkslQyeL/zhi4Br/7vK9lX0Nt2DnNiFewsj9YtaguKNa1F7zjOKGIrGq3zcs0zpmEVMki+7P77g5XS9x9KiOtGk0f4sEx/BvFkMHmQcuuloQC4mbtRVo0EkwSwm84eZ0jsJS6WWCMsW3Y8H9lGI4RKQkqbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R2iulv1m; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2iulv1m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaierQAjwFAsW0ArlhGPhNDIIFXa8hrZS5vKchJkSuPYEwWmNFt5Qjauo7zmdCo+rDSMeSfXyqemU39G0oEzqqW1KrUjK1UGYU244W+hcSGQ9jNe645QoZqfrRUjayniMYEoXxUIFVjeoM1zEYiYj1/FBI8JbtkbTdhmRonYRRbYhWEdt2PLqRFIReX5PAJRu4bF/aD6TYpqvnQQexhmnxpMhMlOdafFV40egu1ctIr5jroer6hRNMY+MsODeJ/dRoyhiyJPviDP0Gac4ePPumRZYQabb8C9VbpnxzJVEnzS7ZgC7kJU7bB1UK16oUqywBQbwwyjKCoZPSH1+pX5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=bEhDhF3BlSNcHMEvUcK2ViqC4FYeGQ4cI94faKfFl7XrGEAGHNzRshL1/a5iJNyXNhLNNXQrcLVxLVJ6Fj00Bdv8kL4FD3he1C9Nq5wxDnJhoMlLEfHJZLMyhWglwkvFOBJ7mlDdvsr5P6DXsbp2XJ2mYCYfj4BSpsMuWLJOb+L1/mfhWOt/TyNvIYJX8i+pSwI329IegbqhpVWkc5miByT+CiZJ05pY3Tk6M/E3eMm2KQTdLE8RVBvVJbDZ6P4eOVATXUUXQKWjLGqTRNvFrDikye6+c1s6k05+mCB/J/Rtz5XmhApD73cd3KEFkhHP2U69UU4PKA9YWez2GnYMKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NAfJqXK6yR1bKhacRp2sfn8rR8lZKGyMVv+Hs+tgPE=;
 b=R2iulv1mtHunX33mwXAIw/XBU+iwCVJ1r5d+J91ncEOwXozFvpMeEx16lA3zpIvGedtOYwMeDusuQIN69b43r8IJgAFelk5R4yFp9RVq5fDtJ4XGKzL8CN5yVyxkTKky9auzjNZenwfIGzfBDzSlWAWfgiSSs2sH4DQMjilfwDVYHplpyhtrY6M4hlOhi/4TinPiY3fPB7/eJsVh+AZJfeS2ZU/PYPiydhumFS1rmG0040FRKhujmMQe2f+HLzpQBe+jWbX0mjVpkt/iEz+sd9UcjYXfQOz7Ev3E0P76/OBdxZDvfcMF90y4mbkRAYrNKa0FgKylc8iOYGMwNhLkSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11503.eurprd04.prod.outlook.com (2603:10a6:800:2c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:48:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:48:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 03 Nov 2025 16:48:29 -0500
Subject: [PATCH v3 2/6] perf/imx_ddr: Move ida_alloc() from ddr_perf_init()
 to ddr_perf_probe()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-qm_dts-v3-2-2bfda8ee14c2@nxp.com>
References: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
In-Reply-To: <20251103-qm_dts-v3-0-2bfda8ee14c2@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762206519; l=2517;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r8swxstYdfH7JP13mlqRiDOFoi7eOmtRK0Mk1iqdXPo=;
 b=bJTlPpTOa2AObGt48UM71eY8JxNC2xN8D2ieSCLDx8eD9c2OUimsqeXldQGVN7kj3rDRMjcNe
 GwSVEsxqTCXBTKxdMqREJBgY8UqyiH2OypzReuXKzTddcEDrk9+5EEh
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11503:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c413f6-6bb0-4203-27ce-08de1b22c8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVhveE12ZFAzSGV5cUQ1VlRBeFhBcjZ3cEd1UlNIeVVVUUNLSlFzNE5vcU93?=
 =?utf-8?B?YmpHUWFyeEtXczk4WjNFejJnSTg4UldLamlNMnQ5Z2Z6ZXFBSGxhZC9xS0ty?=
 =?utf-8?B?ZW5zOTdiL2FpKy9icXJSQld6cXROQ1o2eXhkTTJzMUhpUU5Mb204cmYyQVo0?=
 =?utf-8?B?OEdxZEU0Q055ak50V3NBcEo5em8vWTluUCsyT2JsUlNwd1NPOHJLM2VSTnJV?=
 =?utf-8?B?ZUFrN1kycjhBa2UzUUhEN1F3cjlOOWhlYTVzbjNFU1h5eldvWERmL1ZtNmx5?=
 =?utf-8?B?Vi9Jc1JlVzAzZGJJSVlXWWQyLzc5anB2cTVWVkl1dUhvblVVN0xldHVJeTlE?=
 =?utf-8?B?N2lDam9ZTFVqekN3U2FmTjFIdmJCRGd3NEZ1eXFpOG9qY2d2UTdDK2U4TEgw?=
 =?utf-8?B?VDcrWGIvN3dweHBONFh5YjMvc005N2JQaG1KNktaeWQwR0VCWDNUTlNKcXdV?=
 =?utf-8?B?QjVvS2NwQWwwUEYyd2ZyQU9MMm5mcGUzQVRuZTVGSmxNQ3BGR09JZXdkTDBt?=
 =?utf-8?B?cjUvcVFBenR2Q2tzaWFnTndPWFN0SGJxRVVuQWxRbUk1eVNzY1dCdzdSNlRv?=
 =?utf-8?B?M0owdnE5cHFwT05hempPS3gwM0xTbkcwS2xHVi9RRDVwNEhNZjVYekw2VWVk?=
 =?utf-8?B?NCtlVlh3cTVOVFdTa3ordDZGTmpzT3l5Y1hsTlQ0dUJ5N1FYYWlaSElHREMz?=
 =?utf-8?B?ZVlleU0wcEJTMU8wcjNmT3lWSUUvN0lRZ2FScDliVGhIaGEwcDE5SzhtTkNM?=
 =?utf-8?B?c3hyd2ZaMEVZNGxZQ2J0NFI0dnNMbzJmclpPaVpkKzh6S2pkTlE1anpBc0FB?=
 =?utf-8?B?VUQwOG5KbWQ4RHhJNDdnYWxaMUZKSWNlUDVJL3hmM09jVXNnRUVWbkN1Zm9H?=
 =?utf-8?B?SU9FTzNDYytGb09UdUJneENUM24wMGZsL3AxcHhuQkt4cnl5Qko2QWpmRXNx?=
 =?utf-8?B?NWtROEw1RndXNjlGbjZRditUNTRXUkUrVlJnRldiWlBqM0c5RHlVVXFPRmVC?=
 =?utf-8?B?blZVWWFQOFRKYVFNdkRKNndZQjhJcC8vUm1zc1RhOFN0QU9lV3JnUGNSTWU4?=
 =?utf-8?B?aVdXZ0dGZDZjZWQvTWc3OGpuczcwc093SU1CRWxiRTBNQ1hkOGhNMmw4cFpF?=
 =?utf-8?B?bFlkZGk1ZUNOTTk3OUVOM010dkd5V3hCYldrbVpmRStrbGZCM2xKQzBNZlMr?=
 =?utf-8?B?ZTJZS2ZJaVdST1hpbFJnVmFZaWNyd3JOOHZNRHpqKzZpWDR6M0U1cjFjT2d6?=
 =?utf-8?B?b1FJN2ZMVUlZRVVZYjVmQzVDdWlSdk1ybEtvcWVqTTNZcjBiUURtYVlZSENG?=
 =?utf-8?B?dGJsYjFrQ3o5Ykh0R3RsTnNJbG1NQzNoUFd0VUk1N3lBT2UwSy9PV1hmRWN3?=
 =?utf-8?B?N2UzVWFvSTNrSTc5MW9iclcwdVplWTB6MjNGVVZ1WGI0VFJxM1JLcUtJcDNF?=
 =?utf-8?B?T0laZG9aVXlPZGJ4UEJsNHBVZFRlcDhTKzhGVnhFdm9GSmwybDFISTZyK2xU?=
 =?utf-8?B?R1dkMUk3UjI5WXV0aUp3bkl0VHBxNlVreFl4Skl4cmpMSk1IMWR3bFJKaVIy?=
 =?utf-8?B?b0xtaGZsZnhvdTlQMkJNdmo1NGFXS29rbE1qN21Wd3Z4SHh4NzNPMWNQV1hq?=
 =?utf-8?B?V3BTeVdhaTlVdTFtRHp2a0hiMzMrbEpzRDhPSWQwaWg3QVh2UURNSW9aamov?=
 =?utf-8?B?cVBEelJhQnd5ck1Fcmg5UjB3ai96UENzcTAvVERaeWRGcFZyUWZXaWR1czlL?=
 =?utf-8?B?bVRGT21jUVJ2SjVZdUQwOEVuSVVaeVdRbU93cFcxVFVvTzdJSWtwUlljSDMx?=
 =?utf-8?B?SkZNeGo0NHBNMzdxSGlpeldjeG1ob2FOajgvU3ByaGo4T3dGVnlrajl1K3dp?=
 =?utf-8?B?dWpMak9RMHJHRk9sb0VSS0ZxS1ZhU2ZORForNzFGbUJLbUtyL3VoNG44enhF?=
 =?utf-8?B?YzNhN3pRUnJONzk0R0lvMiswOEs0NGR0cy9QOG82NmFOcHUyZ3l4YzNxeXZo?=
 =?utf-8?B?aitSb3Z1ZlhWS1JmaldKaTBDUGhBcVRBdjBpSXQrSkNOaWV2by9NSTh5bytm?=
 =?utf-8?B?aUpqbXFRYTFMcGFwbUtzemxpaDhudjk3MEl1UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVZTR09TaUZkU3FDREd6Sk5FTC83ek5GdmpPZkYvYTZ6TjIxTDVYM2pLNjlQ?=
 =?utf-8?B?eEpwdC9XcGtEUVlkbmxFQXNOTTRlcjZwSXhhSmdPanBreFJ4SkFBd1VoN214?=
 =?utf-8?B?SEIycm1vWHViOU4vSXRmU25QVlN4RDZTRXRMRHFqQWpBWjE0dUVZYjBEcENF?=
 =?utf-8?B?eHl3STJyazBIVk9HTWJRYmFJK0ZERm8yd1lCQVZTdGZyMVdZRG1RVU5jVVhi?=
 =?utf-8?B?SmNwbHZiYzNGYU1zVHpwRXloTndlK2pLdXlhT3BLVWNsZEQxbUhVU3pseHQw?=
 =?utf-8?B?WDlkbWdoMVZ2bHZMUTZVdWZiNkRSZGxJS1pBZ1RPR2tNTzBybWdLTE0rN1Vz?=
 =?utf-8?B?K25jUFcxeTUxS1ZtMmFSZVdOZmxLbzBMbG5jS2VlTGFzbTJqVDQ5TmZnK3FT?=
 =?utf-8?B?WmFnV291OEpIR2ZLQ1o2b0pWa2ZnVTVIWnRoZ3ZnU1NabUNERkZvWlJKcFdn?=
 =?utf-8?B?WjNLY3RueDlQOTZyL3dsUnFycVJHdVE1WGdrSW9NVjFKN1FKMUNFS2EwOGp5?=
 =?utf-8?B?cVpUaTlJT25sQVpUUDh6NjUyYms2RGtUQ3duaU02dUt1cWVkZWM3R09VVjFm?=
 =?utf-8?B?LzV2ZlBmWVRmbHVnTlFCUHpPd3czNUptZ2JtbWJBVTFoYXNnUDd0OW5DZ3ZI?=
 =?utf-8?B?aDRrdlRjQ0hiOUNnWDRmSml5bFpMRmNKdGZlVlF2d0dqSzRUN21oQ2h0V0ZQ?=
 =?utf-8?B?QXl4Z2pLTnBvRDJSKzlWTVlKOU8yQ3MxYVduU1RhSWZubndhdXpJSnlMd2pY?=
 =?utf-8?B?QUE0UXJzV0JyZ1YxcGh6NXZHL0pNRU5nUmFsK1hvZ3gvak1IUVpsb05McnUx?=
 =?utf-8?B?c1crdkRYaUx4Y2tIQjlWdzdGYVhuUURiZHFreWtMQmNML1RGZ1JUZDlzNEZh?=
 =?utf-8?B?NGpKVVZUQ1JOWmhUUko0WENsalRTMWpxZkhZZ0VSangrNlZnUDBzSGs3NGtE?=
 =?utf-8?B?T0pmTVVmK0phaGdFSFBBelFKMENBenk5VHNPcXV5RW1meVh1dWU4TDRTOWFK?=
 =?utf-8?B?MnhrKzZJdy9KSjlaWEdPTkFxV05TODhnTmRnMitwRUc5eVRWYnVVTndqWFNh?=
 =?utf-8?B?UGFFaG1uWmpLdjZGZ0FLenE1T21PbkU2TklzTnlXWnFqWmR4WU02cFIzdTRw?=
 =?utf-8?B?WnJ2ZzhXbW15c1I1QzBkRVNzOXVCV0N3d3pReFc5YmVNeXg3V0llT3MrcWJp?=
 =?utf-8?B?bDN3cjY4WHErQ1loaDB0bEhHWXpHRTVHRkJVaDg4YTdMRWhpNVhMZnhOSXhj?=
 =?utf-8?B?blhiQXdOUzVHOWFhYVNwQkxSQnNoT3lFYVF5QjVmQTNHRTN4WC9lZ0hqOW5J?=
 =?utf-8?B?T0ZqZmFwaEMyVGZlSkpndEJwR0crMVVSOUlFTjZKMDZ4cjBXYXB1MzJuN1JD?=
 =?utf-8?B?c2tHSXY5c09zVkZTaSt2MVlKdWpJbGVRYmIwTVlWVEhiSkJrcDFlS2d5YzQy?=
 =?utf-8?B?bTE3WHZ5SjIra1BSd1p3bm8rRVNjRGtqcm5sdzZtRU0weENyQllzaXpUNHpv?=
 =?utf-8?B?SkEwUURhWDFlTFd3dlNkL3Zac2toWmJYY3ZSY1p1RS9RVnFVZU9xY25ORVJY?=
 =?utf-8?B?WFlJWDZ4S2RIWW0zRS9XQjg1anRuL1NmWXZXZVRtdmZVTXVoTVNlV2dwSlB4?=
 =?utf-8?B?Z3ZINTRxVFpWaW8vS1BsZnFYNWc4Y0FpUHg2RzlwbUtwSXAwQXlYR3J0WU9S?=
 =?utf-8?B?NFF2cHBaWGd2M09EZTVBMWt4OGQxZGsxM2FQYVFyTDcvMTVQdEhnczhlVWIv?=
 =?utf-8?B?YitKYnBjWFRZTi82eHVpaEZ6S1ozWXBrS3BGWmdJQ1R4RzNxY2tScFgxVjNv?=
 =?utf-8?B?SEIxaWZJTXhTU25SbmU1L2RRTld5M2xTK0Z0TUYvV3JPcDAxTk5GRFRIMEZs?=
 =?utf-8?B?VEpmSjZPZXVIVGU4eHR6M2t2c3loMGpNaU9jNGJ6aFVZSkNva1l0K3crSUR6?=
 =?utf-8?B?N1dGbkdIT1c2Z2VWenlIWjFhWlF0cmpGRVZzSGJzcFUyUWZkdXJLTlNIb0pY?=
 =?utf-8?B?dEgrTHJKMWF2TGlKc1JoWlVvUmZBeitmR0JENFl6RFBPWHEyUFRJYlhoeEFt?=
 =?utf-8?B?SXgwcTB5OHdDS3NiWXZaSUJRa3hBZXVtZXkvNGVmc1VxN2svMmVleFVFVmh6?=
 =?utf-8?Q?m5iLSqqEP3bfuNClcbq37vHBW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c413f6-6bb0-4203-27ce-08de1b22c8c8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:48:54.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2viFDdtlAZUUCSaMAEJqpYUq8bQwKOjSTAtwKuAAeSjQQmB45/a1j/Vu3uQT5xSyCeoCInXUPRQ9h+otEu8ENw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11503

Move ida_alloc() from helper ddr_perf_init() into ddr_perf_probe() to
clarify why ida_free() must be called at the error path.

Add return value check for ida_alloc().

Rename label 'cpuhp_state_err' to 'idr_free' to make the code clearer,
since two error paths now jump to this label.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index b989ffa95d692fce2d42eec08fbc70520c21b8e1..5ba34c606213d255edf27081bb9f63763cca3066 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -645,8 +645,8 @@ static void ddr_perf_pmu_disable(struct pmu *pmu)
 {
 }
 
-static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
-			 struct device *dev)
+static void ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
+			  struct device *dev)
 {
 	*pmu = (struct ddr_pmu) {
 		.pmu = (struct pmu) {
@@ -667,9 +667,6 @@ static int ddr_perf_init(struct ddr_pmu *pmu, void __iomem *base,
 		.base = base,
 		.dev = dev,
 	};
-
-	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
-	return pmu->id;
 }
 
 static irqreturn_t ddr_perf_irq_handler(int irq, void *p)
@@ -753,15 +750,21 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (!pmu)
 		return -ENOMEM;
 
-	num = ddr_perf_init(pmu, base, &pdev->dev);
+	ddr_perf_init(pmu, base, &pdev->dev);
 
 	platform_set_drvdata(pdev, pmu);
 
+	num = ida_alloc(&ddr_ida, GFP_KERNEL);
+	if (num < 0)
+		return num;
+
+	pmu->id = num;
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d",
 			      num);
 	if (!name) {
 		ret = -ENOMEM;
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->devtype_data = of_device_get_match_data(&pdev->dev);
@@ -774,7 +777,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
-		goto cpuhp_state_err;
+		goto idr_free;
 	}
 
 	pmu->cpuhp_state = ret;
@@ -821,7 +824,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 cpuhp_instance_err:
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
-cpuhp_state_err:
+idr_free:
 	ida_free(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;

-- 
2.34.1

