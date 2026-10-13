Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC053FD36;
	Tue, 13 Oct 2026 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925699; cv=fail; b=gdCaRSOcPvXL3qttFVS1+7Gwb8SgiK1LaZQ2JDnsiS65AeuLSd0Yr/mRc7C1NdytdxSXL9IEDx4sq4di0dQgULHiNBNO01mD+tlERTLCfnaa8AdT9Jrs3i+1nZBaq2+rM+zb7yDWcRJ9AuP/DYOX4o0m+roDEU6Ok/tLgsjLdAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925699; c=relaxed/simple;
	bh=7Z3W67uBKjqOpzrM1zXDrjA0jQ6I9yLbCxZACwco2So=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hwMRghKdk4+nQ3AhwvcFVAWmdVWnmuMJZi+eLzwIiHcXm+k66qd/LyBTghJ9m4GdrR50+iMl6UK1pkUrCc20iGQ038EfE/2UA34dNEWKzKJjxFw9rsAXqDqR2EGl7nAI92EXOh7jWuv8yr7tAUw8BhGHlYZ2UryP3eSwfcz6Knw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PeLhEqPN; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PeLhEqPN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAVkVIEnvOfY+XfaYPqFenEkM7GzZAoF1D+yaVRpOBt8AaZ0SLRv72oobWhgeYl14LftBo2+hB6VzXTqbTXH1Iw84OCdhXhSSf9NA0+8l/xSPSAM1LmX/YKoktE4bfjVlGrnWvm6YIovlAWnmH2EB30OyGlRIbG1jlPLqQv33EOn9TdRcFyWW2cTsxHGgY8TaJ8kIUzBLOCwKAEIvXTPT+f+7tNZdvu1k7p+f14VdF9BMCySrFo3kWmZmMGHGOoxzbZzH55/3RPnXdDoEDIqencprgCsSagAbLhC3f/VuKeaOMBYYTw3RTM5NdQlqGcJCn9htdmK0lssHV4S3LxXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z3W67uBKjqOpzrM1zXDrjA0jQ6I9yLbCxZACwco2So=;
 b=ZE8WSBDlJ4RtfekodrowloN4CvbmC5ow5AaRE63OkgkBC+/YkT3OUOIYGBpJalJjPVZKHPi6NQ+aZz8ys9sEoAqIOBMPzaQaej2b3w/Clv/wCZSR0ZxbITyTB2PxAurdanP3RaP+heWhhL0pqElRO+GoQz93hOSC9nbrjuE5L+7Oi6xNDYPlH1Z/5nhjDoYUd26EF4d014/OVT3gQKtgLt/8XdmwFjzr5WMVjhR1jEzKhHMgB15G32Fx8aOQwVgVqBX1BG2FRyQu7tyHw6xY4M3AyvXyTHatjZSBFH9WsjOHxsoy0zhjNB3jdnh8uwUbjnF9NnZAX4Ge1PMNPCHc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z3W67uBKjqOpzrM1zXDrjA0jQ6I9yLbCxZACwco2So=;
 b=PeLhEqPN6a7g135CqFAWSlHtBNtcKbBHwQBfSthC/7VPkDaUWPq0KxzjY5BtJUNRo73Qz0o2TsNuU+USEzt8PCKE1uTiEKQClOgzudS+688bPkFDDMFDMVPtDgMqiC7BBVtwK6FIpGzAu5o8Se0myMIEv2KCR+25X0WFNod9gy5M3TIXWoNliY9IWv05K2gVXtgaSC4AxuJzM91RXk9MpGjg2DdAbD01VNAI8d1nc1bt06Me6+A4uZG8G3jfbe2Fn6bD2dkUXUTBveVhkPaWSAZ75gEr5OtCKuXNzn63QPzoeI2uZJfRNKibz9bFoG3ey5Xgs9fwqdqDfdUu/5n77g==
Received: from SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 21:08:11 +0000
Received: from SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf]) by SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf%6]) with mapi id 15.21.0496.019; Tue, 13 Oct 2026
 21:08:10 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Chun-Tse Shao <ctshao@google.com>, "acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "irogers@google.com"
	<irogers@google.com>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "james.clark@linaro.org" <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Ochs
	<mochs@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Rich Wiley
	<rwiley@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Raj Joshi
	<rajjoshi@nvidia.com>
Subject: RE: [PATCH 0/2] perf jevents: Add NVIDIA Tegra410 uncore DDR and PCIe
 metrics
Thread-Topic: [PATCH 0/2] perf jevents: Add NVIDIA Tegra410 uncore DDR and
 PCIe metrics
Thread-Index: AQHdT3IDbEgMjhro3ECJRaDrDDHWpLb7+jnw
Date: Tue, 13 Oct 2026 21:08:10 +0000
Message-ID:
 <SA1PR12MB6773973955784D66D196A7DCA09E2@SA1PR12MB6773.namprd12.prod.outlook.com>
References: <20260928175127.1032535-1-ctshao@google.com>
In-Reply-To: <20260928175127.1032535-1-ctshao@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6773:EE_|SN7PR12MB7252:EE_
x-ms-office365-filtering-correlation-id: 5ee6be71-604b-4637-b753-08df296e166c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|11063799006|38070700021|56012099006|18002099003|22082099003|6133799003|10067099003|261009223027099003;
x-microsoft-antispam-message-info:
 0tFkGGffnR6Hadg7B+Rk7/5whQ1X3xAI3EjosQM9TSIEx6Jw8IH8ipXd03A3pdCit2+5SH9jCSsUdGhgxzJE8TU35D4+9VbIK9zuVsHykb9CSPaR3ShcI3HhwNCh6T0BrxLdSrM0U5wbaCZhHS8Zrv4hs17oZsHoPfirR3F48MVcvvzatXuX3bTYdcK5GWA9u8A+GjufoGU0LywcUTN6SJV514cgkMfAdPaxcpBUxxDUTxOUT77nla8ApY/ezlMmesx5s9JIl7AgiQtVnOjoXyjrWDbVHzmsR6LkaQpr9nSI5BC97T/Zh87sI7LCIt2jAFdX52aiBPL/RCvofKJtXeTCGbRIk7dMbaSSMwYaapecdyG5QD2JjjPM1m71ug1kBKfyQv/RxIDJbMLyyHjCDIWqd7C790i2S3upQFfCys2P8Rdr3AXsadYvdFDYfI9VcEWdfrv5tqy5JbF0S9Bkhm68GEJsuSepk5RWS7qhrDKkUWF1F7ofGvCxlUwy/PgMC3RvTkb8jjUXR7JqKljZnWLadWUQdu79jAggGIgK0IU0HC7nivLED4n/lke/cQHTWY6oNZF2ydoeniVrVHBlYlgz53mrrAELg0LrnwuvtV4g1TZreHvAtWtFjz/fi920GhIJ6qHvZk0wkUD3F1+8d0Nk7ZUCr/nRyFJgLzedKoVXamD8t8kZ1DQ9dx47WDU7jKbPjDoIjBls6/CLfO0fBw+xOTkxx2Jbtxi8i6LV7J8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmRJam44QURoam9TdHFyWGpEcHgvRXM1QU9iRWIrMjl2SnlHNUJvU3FXWlBT?=
 =?utf-8?B?N2FvVE13RitncDA5SElzUWZ2R3R1UzJXQUN5WktNTjY3R01RRnZqZzhuRmh2?=
 =?utf-8?B?azF2bnkvanNMb2s2T0RldzJoR0huSjBkU2MvY2t2Ui9uVXZ5RzVLaGdHUEk2?=
 =?utf-8?B?cnVsYmNBWnZMZzBYSUp2enpGVnRnTjFOV01oclpYZ1AzRWhpbFp6RU1RelpL?=
 =?utf-8?B?S2JuYTNqNmdSV3QvUmRiNXpadXozYm9weXNXeW9QR2NvelRDMHlDSWRDUWpu?=
 =?utf-8?B?aWtGMVhFam9Da0s3NG11ODY1c2VERFNsOVNnNmJGaVNNVy90SGExQUhGSjgy?=
 =?utf-8?B?V2d3Q0V4NXhDUmJmdmsrRVBXNzBvbENtOTE3RWRFRmdZOUM2bWtMSU01QUdw?=
 =?utf-8?B?aEFPMjJoWFlZczNzSGVVdTBncnNDa2Y4OEY2SUtxdWU5MFhwSmJSZDkyMC9V?=
 =?utf-8?B?ejdkUnQyUlptMWpmRzlaa2svZkR4K2krUWRENmpiN3BoVUkySEdCQ2JwcnFP?=
 =?utf-8?B?MlhOWmkwZTRWZUF0M0xYVHpFYWNZTzJwa1p3NklmbmZ6WkU3Vm5DbjdaZFRX?=
 =?utf-8?B?ZWFreEtrb295WHVWNWtscjdjTDRJYU9wYXdlWWhtc0xSenRENDQ2V0tzaEJu?=
 =?utf-8?B?MEdHQVRRWEJ4MFJUVXpaeFcvakwxdDBEbXRmUC9tUDJ2YWlqaDNFQjEvK3hp?=
 =?utf-8?B?NG5SbVI3ZnNoanZLOGFPNmRPenppNVNxSTFLU1R1Wmc2bGdwdGhuWkc5Skl2?=
 =?utf-8?B?UHJ6R2c5VEJRWTZvSjFGYkVZanlzajZaMzZiMUJ4UGliSlk4NjRkVVpMa3Vi?=
 =?utf-8?B?N2xzd0FsL0RyNnB5VFhMZVp6Y2hsck5qaVhsRzl3a0pFeWx1Q3U5WkZOdWdt?=
 =?utf-8?B?dzJEY0xQdlZTVUlLZGhoWEJjbkV6dGlVNmVaYTd5a0ptMk1mVnhVTEZWaGg3?=
 =?utf-8?B?dGNCcXFxbnhES21tZkcwbHBLV3dCSklqanZzanBWSWNSZENvZU9YL3lxbk50?=
 =?utf-8?B?RTRKSGI2QXV4NVV6T3RHUmo0bXQxK2h3RCttM005Z2xJT3premdYSHNtZUhK?=
 =?utf-8?B?M0Y3Y2Z0SDQ0TDdVOElZeDVpOXAvNmttbkcrck5KajkyVFF3MUR2dkZnUU90?=
 =?utf-8?B?VEd1dlJLNXhEU21rRFV2d2ZnczIrMy9VczJEd25tTzZQL1JUeEptRWVEMUg1?=
 =?utf-8?B?enhjY0VsTlJ3WTZ6QVdxVnpFWU9pM0lTT2kwNEtBRVIxZk5WRWdXT3ZCaHI5?=
 =?utf-8?B?bGRyWGlXc01pUTRHSTVJZC9XNVQyMzdLc2NWSjlXSVkyYVBnRlJZMlNiemRD?=
 =?utf-8?B?eEpBV053VXlvL3dHOUtweFlIazJoUENScmhzZHdjemxZcWdUay9sNlcyVXVH?=
 =?utf-8?B?dXA0VEplTENZOHBVdEc0OGFrclZDRzJZclFFTnpwMmhFRnZwNFZVeElFOFZn?=
 =?utf-8?B?QWh6T0ZoQStvbE83ZzBUbGkyUHNaMUcyRTFUQVNuVGd0Rk0xYVduc2RaVlNH?=
 =?utf-8?B?aktZdkZvdmlRYXlxTVpCWDdPL0FDME1YSkZna0Y2UVZpSjRBZnNzbUo1cng1?=
 =?utf-8?B?M2xLNjhWTU9HMGRwK29SSEU0Z1Zmblo5VVd3a09GcW1iZ08ybXJSNnNnVE4v?=
 =?utf-8?B?Zm5vdkZuZkNyTEd5dmp0eHBTVSt0bStadmVYNkZ2SElTVUJ0em5ManFVZHpC?=
 =?utf-8?B?aHY4TFhFTmw2V2dNanJmNW1aalJoa1VqeU8vbkdZdDB5Vk5ETG5HKyt0Nndw?=
 =?utf-8?B?cXE2WHkvcE1qNW92Y3hIaEFiTFpsK2x4WDgxLzd3VWo2MEVIV2VHQ3JMQnV4?=
 =?utf-8?B?TFNEMm10ZjJzb1hGU2JTZFpONW1kdEpJNGFoamcxcUNDWEI2eFY0N1VDcTBJ?=
 =?utf-8?B?ODVxVlRTZUVtNHh2UjljQnI0dUl1REtlUEt1T3M3cFNjKzkyZ2lDNXRoa3lq?=
 =?utf-8?B?M0xQaFc4TnVlaVdteWt2Si8ycjBPUmNwQkd6WCtVUTgvUkNKQi9BMlZkR0Za?=
 =?utf-8?B?NWpXVmY1SE5nUEtmYjIwanNoUGNnZlRNbFpjazRaVUIvSUFIQkM3dE9vM3JO?=
 =?utf-8?B?UFI3YU5CU0RjUzJRWG53ajArVnMvenFpaTYzY2lianRrN0t3T3NNMjhTUnRP?=
 =?utf-8?B?UVVackEySGgxMExKT1l4Z2tJRDgvUzNDbXhxUkoxeDNsS0RIc2R1bzhZUUUy?=
 =?utf-8?B?ZFE4alcyY1l5YXFFRmdBd2EwU2J6d0pyZ2V2REh4blRWOUxjZkRPMCtWQ0J0?=
 =?utf-8?B?d2pwYkltZDVzYTNuOFp1OWtSTWNRc0VrQ2oza1JUZEZQVlZubUhKanJrUTc4?=
 =?utf-8?Q?14kaIY8TPvR2gthPg2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee6be71-604b-4637-b753-08df296e166c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 21:08:10.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpsAaOmU9sAjUYBxLcPawPc3eEqRSJW/fh9del2M1gwzohSVYMELWtG+CR10WZMf6Vrg+ReGh22BItEwwvvfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

SGkgQ2h1bi1Uc2UsDQoNClRoYW5rcyBmb3IgdGhlIHNlcmllcy4NCkZZSSwgSSBhbSB3b3JraW5n
IG9uIHRoZSBKU09OIHBhdGNoIHNlcmllcyBmb3IgVGVncmE0MTAgdW5jb3JlIFBNVXMsDQp3aGlj
aCBhZGRzIHRoZSBldmVudHMgYW5kIG1ldHJpY3MgZm9yIHRoZSBzYW1lIGNvdW50ZXJzIGluIFVD
RiwNCkNNRU0gbGF0ZW5jeSwgUENJRSwgYW5kIG90aGVycy4NCkkgd2lsbCBjYyB5b3Ugd2hlbiBJ
IHBvc3QgaXQuDQoNClRoYW5rcywNCkJlc2FyDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogQ2h1bi1Uc2UgU2hhbyA8Y3RzaGFvQGdvb2dsZS5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgU2VwdGVtYmVyIDI4LCAyMDI2IDU6NTEgUE0NCj4gVG86IGFjbWVAa2VybmVsLm9yZzsg
bmFtaHl1bmdAa2VybmVsLm9yZzsgaXJvZ2Vyc0Bnb29nbGUuY29tDQo+IENjOiBwZXRlcnpAaW5m
cmFkZWFkLm9yZzsgbWluZ29AcmVkaGF0LmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGFs
ZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb207IGpvbHNhQGtlcm5lbC5vcmc7DQo+IGFk
cmlhbi5odW50ZXJAaW50ZWwuY29tOyBqYW1lcy5jbGFya0BsaW5hcm8ub3JnOyBCZXNhciBXaWNh
a3Nvbm8NCj4gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT47IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgQ2h1bi1Uc2UgU2hh
byA8Y3RzaGFvQGdvb2dsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzJdIHBlcmYgamV2ZW50
czogQWRkIE5WSURJQSBUZWdyYTQxMCB1bmNvcmUgRERSIGFuZA0KPiBQQ0llIG1ldHJpY3MNCj4g
DQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1l
bnRzDQo+IA0KPiANCj4gQWRkIEREUiBiYW5kd2lkdGgvbGF0ZW5jeSBhbmQgUENJZSBiYW5kd2lk
dGggbWV0cmljcyBmb3IgdGhlIE5WSURJQQ0KPiBUZWdyYTQxMCBTb0MgdG8gYXJtNjRfbWV0cmlj
cy5weS4gVGhlIG1ldHJpY3MgdXNlIHRoZSBzeXNmcyBldmVudHMgb2YNCj4gdGhlIFRlZ3JhNDEw
IFVDRiwgQ01FTSBsYXRlbmN5IGFuZCBQQ0lFIFBNVXMsIGFuZCBmb2xsb3cgdGhlIGZvcm11bGFz
DQo+IGluDQo+IERvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcGVyZi9udmlkaWEtdGVncmE0MTAt
cG11LnJzdC4NCj4gDQo+IFBhdGNoIDEgYWRkcyB0aGUgRERSIG1ldHJpY3MgYW5kIG1ha2VzIHBt
dS1ldmVudHMvQnVpbGQgYWxzbyBydW4NCj4gYXJtNjRfbWV0cmljcy5weSBmb3IgdGhlIG52aWRp
YSB2ZW5kb3IgbW9kZWxzLiBQYXRjaCAyIGFkZHMgdGhlIFBDSWUNCj4gbWV0cmljcywgaW4gdG90
YWwgYW5kIHBlciBQQ0llIFJvb3QgQ29tcGxleCAoUkMpLg0KPiANCj4gVGVzdGVkIG9uIGEgMi1z
b2NrZXQgVGVncmE0MTAgc3lzdGVtOg0KPiANCj4gIC0gbWVtY3B5IHdpdGggbXVsdGlsb2FkIChm
cm9tIG11bHRpY2hhc2UpIG9uIHNvY2tldCAwIENQVXMgYW5kIG1lbW9yeToNCj4gICAgbHBtX2Rk
cl9idyBpcyA3NDAtNzQ0IEdCL3MgYXQgc3RlYWR5IHN0YXRlIChwZXJmIHN0YXQgLUkgMjAwMCks
DQo+ICAgIG11bHRpbG9hZCByZXBvcnRzIDcwODA2MyBNaUIvcyAoNzQyIEdCL3MpLg0KPiAgLSBS
ZWFkIG9ubHkgKHN0cmVhbS1zdW0pIGFuZCB3cml0ZSBvbmx5IChtZW1zZXQpIGxvYWRzIG9uIHNv
Y2tldCAxOg0KPiAgICBscG1fZGRyX3JkX2J3IGlzIDYwOCBHQi9zIHdpdGggMi40IEdCL3Mgb2Yg
d3JpdGVzLCBscG1fZGRyX3dyX2J3IGlzDQo+ICAgIDYyOCBHQi9zIHdpdGggMS4xIEdCL3Mgb2Yg
cmVhZHMuDQo+ICAtIG1lbWNweSBvbiBzb2NrZXQgMCBDUFVzIHdpdGggbWVtb3J5IG9uIHNvY2tl
dCAxOiBzb2NrZXQgMCdzDQo+ICAgIGxwbV9kZHJfcmVtX3JkX2J3IGFuZCBzb2NrZXQgMSdzIGxw
bV9kZHJfcmRfYncgY291bnQgbmVhcmx5IHRoZQ0KPiBzYW1lDQo+ICAgIGJ5dGVzICgyNTguMDMg
dnMgMjU4LjczIEdCKS4NCj4gIC0gbHBtX2Rkcl9sYXQgaWRsZSBpcyAxNTAgbnMgaW4gdGhlIGRl
ZmF1bHQgYWdncmVnYXRpb24sIGFuZCAxMzIgbnMgYW5kDQo+ICAgIDE5NCBucyBmb3Igc29ja2V0
IDAgYW5kIDEgd2l0aCAtLXBlci1zb2NrZXQuIFVuZGVyIHRoZSBtZW1jcHkgbG9hZCBpdA0KPiAg
ICBpcyA1NTUgbnMgYnkgZGVmYXVsdCBhbmQgNTYzIG5zIGZvciBzb2NrZXQgMCB3aXRoIC0tcGVy
LXNvY2tldCwgYW5kDQo+ICAgIHN0YXlzIGF0IDU1MS01NTggbnMgcGVyIGludGVydmFsIHdpdGgg
LUkgMTAwMC4NCj4gIC0gOCBHaUIgT19ESVJFQ1QgZGQgcmVhZCBmcm9tIGFuIE5WTWUgZHJpdmUg
YmVoaW5kIFJDIDAgb2Ygc29ja2V0IDA6DQo+ICAgIGxwbV9wY2llX3dyX2J3XzAgY291bnRzIHRo
ZSA4IEdpQiBhdCA4LjcgR0IvcyAoZGQ6IDguNyBHQi9zKS4gV2l0aA0KPiAgICB0aGUgYnVmZmVy
IG9uIG5vZGUgMCBpdCBzaG93cyB1cCBpbiBscG1fcGNpZV9sb2Nfd3JfYndfMCwgd2l0aCB0aGUN
Cj4gICAgYnVmZmVyIG9uIG5vZGUgMSBpbiBscG1fcGNpZV9yZW1fd3JfYndfMC4gV2l0aCAtLXBl
ci1zb2NrZXQsIHNvY2tldCAwDQo+ICAgIHNob3dzIHRoZSBzYW1lIGFuZCBubyBtZXRyaWMgb2Yg
ZWl0aGVyIHNvY2tldCBpcyBuYW4uDQo+ICAtIFdpdGggdGhlIG52aWRpYV90NDEwIG1ldHJpY3Mg
Zm9yY2VkIG9uIGEgbWFjaGluZSB3aXRob3V0IHRoZXNlIFBNVXMNCj4gICAgKFBFUkZfQ1BVSUQ9
MHgwMDAwMDAwMDRlMGYwMTAwIG9uIGFuIHg4NiBKRVZFTlRTX0FSQ0g9YWxsIGJ1aWxkKSwNCj4g
dGhlDQo+ICAgIFBDSWUgbWV0cmljcyByZWFkIDAgcmF0aGVyIHRoYW4gZmFpbGluZyB0byBwYXJz
ZSwgYWxzbyB3aXRoDQo+ICAgIC0tcGVyLXNvY2tldC4NCj4gIC0gInBlcmYgdGVzdCAxMCIgKFBN
VSBKU09OIGV2ZW50IHRlc3RzKSBwYXNzZXMgb24gdGhlIFRlZ3JhNDEwIHN5c3RlbQ0KPiAgICBh
bmQgd2l0aCB0aGUgeDg2IEpFVkVOVFNfQVJDSD1hbGwgYnVpbGQuDQo+IA0KPiBDaHVuLVRzZSBT
aGFvICgyKToNCj4gICBwZXJmIGpldmVudHM6IEFkZCBOVklESUEgVGVncmE0MTAgdW5jb3JlIERE
UiBtZXRyaWNzDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgTlZJRElBIFRlZ3JhNDEwIHVuY29yZSBQ
Q0llIG1ldHJpY3MNCj4gDQo+ICB0b29scy9wZXJmL3BtdS1ldmVudHMvQnVpbGQgICAgICAgICAg
ICB8ICAgMiArLQ0KPiAgdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FybTY0X21ldHJpY3MucHkgfCAx
MjYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L21ldHJpYy5weSAgICAgICAgfCAgIDIgKy0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTI2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDBhZTZmYzc4
YzVjZTBkZmQxOGQ4NzEyYTUwZjBmZDQ2MDJlZmYxMDMNCj4gLS0NCj4gMi41Ni4wLnJjMS4zMTUu
Z2M2ZWQ5OTM0YjctZ29vZw0KDQo=
