Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792764757;
	b=4VpZSabCXkC0QvuPg4EbiBjxkZQ03v1zgo49RSA7DiOZ3VTfizhOfabr7ufNGTCoP8qx
	 NWeMJDfUJkbXRws7bVbMMISaizcYdqepGJhYBCNtaxx94+Cb6uPFEGJLGhq8mLgGNZO3D
	 IdJEwt9sUxVt4b7EUe7HGTF0le8CKyOarzYKg3q/RT+sgsT6LmdxvqBr2B9kAjbInpeo0
	 U+b84ZDZd+55AcTmpFmwM9zpFN7XGXT5CNFAwVpZJbLEIt30vkQnvJdprDha1Id8/uQ5e
	 XhluBhuSVlNDfqLhgHv5cwAuSB6KJ+6jSy4KozDnTSIOXSp+vbDk/XsEnFOhKEwJcCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764757;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=acVFK2oflwsWzqQfVGqK94DDM5TLCettE0bzN1FAfM0=;
	b=pqHfltb25CIkPJPaYO1SZJ3kilmrcP2zpPHUPwuOvB5+rfjxmk57zoDnZUuikWWDHLp1
	 1S+3OCT+X5YnfsD5XikbmjwSjqC/M3cKla3PrbWD25xlWMpcAoBmvGII1e5QpM25jUXMV
	 C6KPFkVQB8SYZB4EJFzpZ5/8cae6t7VWHkwvCHxbHFbT8aRJGoInSH9bRy2YSIk367z8E
	 b04CL4Ech+ehQOr4SCIfE2JJrgtFamsbeG6b1pltYdhcdJ1HxNgwGeHUGIPx7l1bZ322P
	 Wzr5KHv7jg/n99rmnUbo0Kqis0IClrayKBvEt3TlD3N0xY4AbajB3X4GV36Twx/1WwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.141
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022141.outbound.protection.outlook.com [52.101.101.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D650D606A322;
	Fri, 23 Oct 2026 14:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D650D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klBQZ/XQp6VOxRqVFX9sNXyIqNiQ96u44/3qcFgwR46NMlGXHDnn/lsmevtHoiNlr+SyNlled3MtbI3ESbSwa8w0dN8Zi/QBwMIHvbhkhHi0xycAVS+ft40OOTPsxp3Zhbp4d8VZveQzDI3IXiVdTLRAHjXUxyb6wG/EvbD8/Bi5SqhIPdbpncCmTX28UFcylAZWku1zvSy1DoGf9yDvFqR6XKy1ft0q/jBoSOfH+W4KTDkev8C6e1bdqUvFeLw99w5YfIFK/+5M3evFh88wUwN+JAY5Pf4yppCoC7UsOChX8h9VGhdTkPbYhQV8YG+NZlDykN4HsPzciHz+mmsaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=acVFK2oflwsWzqQfVGqK94DDM5TLCettE0bzN1FAfM0=;
 b=EoYi8Cn3WXqu7U7ng7++roaC4Fzm0PrRgOTMSTpXBY8YZ06Xed2Pou0GbfjTv7QExJsGdPAQRCAg8sNbpdGDT7zPojU4MH+yFkvgu7TlfvemrBlRdyo01ybYFiJZQoJ2KfWgRWNegHj1pvFjHw8TmX9x3mG3ebX6sAWO/NHEtQMTy7BGfbNRunrud6fVEKriHFqH2kgXDvMnaudKpauKA5yTsRzQ/iQcI8Ar8dbUHoeS5Cc7yYw4DurQaVJjrt0CPds2R0XIid1z6fY1pWiULfFb6o+s2HlcLkOzg7PQFYnknGIA1gcffLNIj0D2FsaAYxLYwCUqA6pFNnWm7qlh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2828.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:12:33 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 14:12:33 +0000
Date: Fri, 23 Oct 2026 10:12:29 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v9 4/6] perf ftrace: Support display of
 inlined functions in function graph tracer
Message-ID: <q2s7qutxjcsbagaqetmm3fcyq3w4uby5jl4hpdcrbh64l5jg2z@53fciwptybzd>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-5-atomlin@atomlin.com>
 <atqF8rgKGnaH7EhQ@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atqF8rgKGnaH7EhQ@google.com>
X-ClientProxiedBy: CH2PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:610:58::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2828:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc512ce-bdb4-4c03-d75a-08df310fae8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|261021121427099003|261022115727099003|261022113327099003|261021135927099003|4143699003|5023799004|56012099006|261021123027099003|261009223027099003|3023799007|10067099003|18002099003|22082099003|6133799003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Yrq1C209F140Y6NgxQ0CAEQXJG4UAB/JR45Pe4086cTTzJXjRmm24x7L0urgQclfD/ns54iQjqKl6fnTu2+gav3SS8427HbIg/QdMfreXTfNpfswCt7HeSCd4MSzSH62NjBY3WNB9KMCAXXRcpO6oPFVsupajKH/PQWJTQ+r5vAPabdmPp8YliYBLuUvuMW6C3bOhKcolstjMda9gV5ih7uteD3FX2CWmAxugvaZHl1/Tni/SzuY5iGHUHmyjowLcoBu0FMPiaxdbR0U6PByG9pCrFchKekeGcwS/nSrlC3U7f6LsT0WbHYBwR5/bTxMbP0DkMn+D9WiYTUkVK8mhZrlPakJ+97uibAeSZMYSfsctWkWgkll7LPl95vqBfP5+XBu5Dn7+Sw1VOZjQvXvb+0iCXCKBgNGpQyGE/kCoxbYYp0Wfr2m9jt1R37ChHXuoGSqTwWoiXpM1TJePcY2ixyj0QZkfzbX6CczZwZf9iF+4Md2qnCKLmsT98UoaWeTOQUq8PCiDN+w5yNri/8W5WJ0HU2hWDYhIal6r7JPUjELypLF4wLcgpWLV7hHgEUUj9U/cIq9Uq2J5sMZw4T31NxlDq7L87mshecMYeh0XkIW7e1cP1ltGoicvhv36KKUUk9ASb83JiKb9sbt8lKc8Q0HrCpCtJ1kAm5B1xlJ2l0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(261021121427099003)(261022115727099003)(261022113327099003)(261021135927099003)(4143699003)(5023799004)(56012099006)(261021123027099003)(261009223027099003)(3023799007)(10067099003)(18002099003)(22082099003)(6133799003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXRobWJFdjMyZ1J4SkZ0aFgrQWwwc2E4elpwcEhlRGl2U2RsYTlnNE1DSTVm?=
 =?utf-8?B?a1puYmwxNlZleGcxUkNTRHRmak5kdS85NG8xQnRldXlPZ0FJbmV5dmJ0N2px?=
 =?utf-8?B?eG9mcnFWWlBCYmVyQzcxbm8rRFpTWXVid0FLWlRCdDFtT3RLWkdOb3d4VHNv?=
 =?utf-8?B?S0Uxblg0RFR6OTNqUnk0b1B4bmJXcGtqM1BFOHdaSW1MTVpSbWxHVGlhOU9Z?=
 =?utf-8?B?aTdSTHV5MllLNDVtRXVBdmtZZ0E3ZlV2Q1ZyMTZuZTdnRkZGT1ZEL0VWc1Q1?=
 =?utf-8?B?Q2tTWnYvRngyS25BR1d3YjNSeDlOZ3pHM1JhSTA1ekNjVTd6ZitUakljMHh2?=
 =?utf-8?B?SVhGVWhYSWtOeUx3TXZxR0hQM2pHN0M2eis3TExpaVJuSjhVTEdrNjI0VzFr?=
 =?utf-8?B?Mmd4eW1Zc0hNOXozVzFmNnBGUitZdVg2NG5oc1JlRDZKd2NmU2YrV1pTMWxN?=
 =?utf-8?B?a0NMR1V2ZzJnNmFZMTViMG1HZzdXeGxocVBPeGp3ZW85eFBPVnBHcENRY2kx?=
 =?utf-8?B?TGRuaXY4OEZpQngwN2tha3RGRzZkenU5bHEwSHZRK0lhN3BYSlBPS2NONFpn?=
 =?utf-8?B?em0ySHpURU1EQ2oxQ3B4MndWc2JmR2Q5bHprdEs1UGQ0SmtVQ21oN3JkczUr?=
 =?utf-8?B?a1RCRjFybUgwQ29rQTV5TTRGZmVaL3V1Y3hDUVEvUVZXcEFLbE5OMkRJUjJw?=
 =?utf-8?B?QWQwRkMxL2grVHEyWDM1ZGlKZlBqKzFSVzBLYTVHVUtSTk9KdVBjK2dlZ3VF?=
 =?utf-8?B?eHYvcnlKZ1RJN29VcnkxMGZaY3l6Ti9EcFFVOElJWlh4ajRiMU9sWElqbWFB?=
 =?utf-8?B?Q013U0ovb1NjMEN1Um4ycnNaSXJCa0NOS0tYSWZCSzQyM3MwNEc4Si9UUzh1?=
 =?utf-8?B?d2t4eXpqYjhXSk5sKzAraXVVTG5JRENoNllsVU9QZDBxd3M1NXNQaitWakx4?=
 =?utf-8?B?K3IrOU9KSk5PcFI5dllKM0k2b1BwNXpWeCs2WG0xakRBVnlQVXNSQmtZQ1VS?=
 =?utf-8?B?bGE4aXhQY042ZTR4TlpjNVEydTQyNFpVbFdLTk82V3VOeGljWGJ1b1I1OENi?=
 =?utf-8?B?eGtaOFdwRUVod2JJem4yTnlNRERJR0FySVIyZHRyM3BYWVZFYmEvNUoraUY2?=
 =?utf-8?B?dUxBRDB1MHR4eWlvN0d2dGFlYkNGbU5mWWpqQU1hcmFoS2ZaS096eEQvRGk5?=
 =?utf-8?B?VXpHc3Qxd2FzeUtrN1NLUnZIc3RDZTB4ajVGRUYvaXk1K2p5TGVsQU02TXla?=
 =?utf-8?B?VFRKQk9jZ2xRMERFcDRneWpleGtUU2ViWGdSb3Q4ekFYb2QreVhyVlpFdkJo?=
 =?utf-8?B?MnZROGlFaGdwci9NaW9KWGcwaS9qeHJRZmltcjBwcTlXV3VGbjdUaU5NUjhI?=
 =?utf-8?B?MXV6Z2pValU0MG5sWlVLcUx5bWhFVkZoa3VBbDY0OWZVVG5wVUFtQUhKbDlr?=
 =?utf-8?B?V0dqWEhRK3dqYkFZUGZDeXJDelV5VkE1c2U5anFvcVRxNW1kSnFSTm9hV0lj?=
 =?utf-8?B?MGEyb0tZUkZNenFUSzJEM1laUkIvUmN0R2dkMmc3djVYL1VORlkxN3MwdytX?=
 =?utf-8?B?eWtyeTR5MGYzOHhsU2FCa1BSaXo5NUtMeFdOMkIvcDVySTNnTEVjNE45Nlo3?=
 =?utf-8?B?ZDIwaXZPRlFaRlJUY2Z5QVBGQitFMDM4OWVobVZqc1FNbU15UURiUXd4Q2pS?=
 =?utf-8?B?ZVROZXB0ZWNYcGRTMEN4NE8zeFBIK1JmRnFLejFFVFBvR0paY3hiTEtVOStD?=
 =?utf-8?B?aEgvZ05xZUNva1FtYXcwM1h6bDBLVGxXV1BTNFo2S3BLNHZFYjIyeko5NU5h?=
 =?utf-8?B?SDNpQjk0aTVFQWlLbDZzMGxUME1mZi8vdVMvdkxZQ2lFTmpINUtHQjN6ODFQ?=
 =?utf-8?B?MHgyMjh2Y1hzT3gvNE9nUWN3ZklNbDJoWjRyM1Jnc215Rm5PNXhpSVB4NlRB?=
 =?utf-8?B?M2JXa2dvRWpnTDFLdzY2UWp1R0tvV3NEZ1pzVGQ2T3lqKzlYYkE4WHRHd2Ey?=
 =?utf-8?B?all5aG52U2daSjE4Zkk2ZVNQYjFiamkwdFAyNGJRakdXZXRua2ZTWDNablV5?=
 =?utf-8?B?SVFWS1grcXlibTNoL3BadkFRMXF3OG1FV3lxM09xVWp5ZlVGV1MydjFDVFNT?=
 =?utf-8?B?UStZN2lJOTlPQWllbWxTcmxSWmxlNlJuSytQQ25IcEdxVU15Z2FaV2VCYjNZ?=
 =?utf-8?B?bkUxb25ZbGd0QlM3RHlvWjFRQm51cDBFV3R6SmE2TkR5aEpOSWJReWJZS2FC?=
 =?utf-8?B?NmNPK0V2L3EyWlB6cUg2TXBTanJ5NGp6eDFyaWlPT1dETWNyQk5TdjhGbnZn?=
 =?utf-8?B?TU1Vcyt6TVNJMGU0d2J3blVFM242MzNpRGxOVjVyL05tL3VIVFhxQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc512ce-bdb4-4c03-d75a-08df310fae8c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:12:33.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhehTOttu85cu4Uak/bN2mVS4LPwkSE8HhtW6LdjYwFZG2EU/YDvGKpcWjn5OxvHPTTKp7pxWrWzlyYoLAw7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2828

On Thu, Oct 22, 2026 at 02:53:54PM -0700, Namhyung Kim wrote:
> On Tue, Oct 20, 2026 at 10:33:35PM -0400, Aaron Tomlin wrote:
> > The Linux kernel's function graph tracer operates at the machine
> > instruction level via compiler instrumentation
> > (-fpatchable-function-entry), recording entry and return events for
> > physical function calls. Consequently, functions inlined by the compiler
> > are invisible in the resulting call graph, as no discrete call or return
> > instructions are emitted for them. While technically expected, this
> > omission frequently obscures the logical execution flow when analysing
> > kernel subsystems heavily reliant upon inlining.
> > 
> > Address this by introducing the --inline option to perf ftrace for the
> > function_graph tracer.
> > 
> > When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
> > funcgraph-retaddr trace option records the caller's return address on
> > each function entry, manifested in the trace stream as a comment
> > (e.g. /* <-irq_work_queue_on+0x81/0xa0 */). By interrogating DWARF debug
> > information from the kernel image (vmlinux) utilising libdw, perf ftrace
> > resolves this return address to its inlined callchain and synthesises the
> > intermediate inlined frames directly into the streamed call graph.
> > 
> > Key aspects of this implementation:
> > 
> >     1.  Inlined frame presentation
> > 
> >         Synthesised inlined functions are rendered with an explicit
> >         /* (inline) */ annotation at both entry and exit:
> > 
> >             # tracer: function_graph
> >             #
> >             # CPU               FUNCTION CALLS
> >             # |                 |   |   |   |
> >              6) activate_task() {
> >              6)   enqueue_task() {
> >              6)     enqueue_task_fair() {
> >              6)       update_curr_eevdf() { /* (inline) */
> >              6)         update_curr() {
> >              6)           update_se() {
> >              6)             cgroup_account_cputime() { /* (inline) */
> >              6)               cpuacct_charge();
> >              6)             } /* cgroup_account_cputime (inline) */
> >              6)           }
> >              6)           dl_server_update() {
> >              6)             update_curr_dl_se();
> >              6)         }
> >              6)       } /* update_curr_eevdf (inline) */
> >              6)       enqueue_hierarchy() { /* (inline) */
> >              6)         update_curr() {
> >              6)           update_se();
> >              6)         }
> >              6)         enqueue_entity() {
> >              6)           account_entity_enqueue() { /* (inline) */
> >              6)             account_llc_enqueue();
> >              6)           } /* account_entity_enqueue (inline) */
> >              6)         }
> >              6)       } /* enqueue_hierarchy (inline) */
> >              6)       place_entity() {
> >              6)         avg_vruntime();
> >              6)       }
> >              6)       __enqueue_entity();
> >              6)       dl_server_start();
> >              6)       hrtick_update() { /* (inline) */
> >              6)         hrtick_active() { /* (inline) */
> >              6)           hrtimer_active();
> >              6)         } /* hrtick_active (inline) */
> >              6)       } /* hrtick_update (inline) */
> >              6)       hrtick_start_fair();
> >              6)     psi_enqueue() { /* (inline) */
> >              6)       psi_task_change() {
> >              6)         psi_flags_change();
> >              6)         psi_group_change() {
> >              6)           record_times();
> >              6)         }
> >              6)       }
> >              6)     } /* psi_enqueue (inline) */
> >              6)   }
> >              6) }
> > 
> >         This affords immediate visual clarity to the reader upon
> >         entering an inlined scope, without necessitating a search for
> >         the closing delimiter.
> > 
> >     2.  Call graph reconstruction and per-task stack tracking
> > 
> >         Maintains a per-task synthetic call stack tracking real and
> >         inlined frames across context switches, synthesising entry and
> >         exit delimiters to accurately reconstruct the execution
> >         hierarchy. Tasks are tracked in a hash table keyed by PID, with
> >         per-CPU active bindings updated upon context-switch banners or
> >         verbose line records. Inlined frames are structured strictly
> >         root-to-leaf and validated against the active stack to prevent
> >         un-traced callers from attaching orphan inlines. Bare closing
> >         braces without trailing function names (the default when
> >         funcgraph-tail is disabled) are correctly matched against
> >         preceding frames on the stack. Context column alignment,
> >         including task comm-pid delimiters in verbose mode, is preserved
> >         when generating prefixes for synthesised inline frames.
> >         Furthermore, stack depth saturation guards ensure that inlined
> >         frame depth tracking remains clamped, indentation cannot drift
> >         even under deep call trees exceeding FTRACE_MAX_STACK, and
> >         overflow depth is automatically recovered upon caller detection.
> > 
> >     3.  Option handling and diagnostics
> > 
> >         Adds -k or --vmlinux to designate an explicit debug image, and
> >         provides clear diagnostic guidance should --inline be invoked on
> >         a kernel lacking CONFIG_FUNCTION_GRAPH_RETADDR. Automatically
> >         enables return address comment filtering unless explicitly
> >         requested.
> > 
> >     4.  Automated verification
> > 
> >         Expands the unit test suite in tools/perf/tests/ftrace.c to
> >         validate DWARF inline symbol resolution, comment filtering
> >         toggles, bare closing braces handling, task context-switch
> >         isolation and migration, and stack saturation/overflow recovery.
> > 
> > Assisted-by: Antigravity:gemini-3.1-pro
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  tools/perf/Documentation/perf-ftrace.txt |   17 +-
> >  tools/perf/builtin-ftrace.c              |   76 +-
> >  tools/perf/tests/ftrace.c                |  914 ++++++++++++++++++-
> >  tools/perf/util/ftrace.c                 | 1059 +++++++++++++++++++++-
> >  tools/perf/util/ftrace.h                 |   14 +
> >  5 files changed, 2059 insertions(+), 21 deletions(-)
> 
> I think it's too big and you can split into pieces like:
> 
>  1. add the basic task stack management code
>  2. support context switch
>  3. support inline functions
>  4. add test code
> 
> Thanks,
> Namhyung

Hi Namhyung,

Acknowledged.

Kind regards,
-- 
Aaron Tomlin
