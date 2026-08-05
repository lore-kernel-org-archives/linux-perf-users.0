Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022101.outbound.protection.outlook.com [52.101.96.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498D427F97;
	Wed,  5 Aug 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959930; cv=fail; b=lrFi6DjG/uP6N1o04uCoP8gvBUtFAOTF8Gnw4Vtgj8s1aJm7xb/YyYoepVOvTVa4u38Wq+Yw60oAupamVLV8EGorhJZyax8p0yYrdMO1UrueZO53Wb7Cw1XfJbksxdzH/tqM+G6rTeKsdEiV3H8xiQd2jcquqXGoGpuXEwdKkJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959930; c=relaxed/simple;
	bh=toBeaIbyXDHLW7SPEd7fVtteviimsswRL2+4jbwG++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=arLtQQqD2Bcvv4xat3OAkxBkxZmioso67eeLqLHwhQMRHzrDzKdspoWihzUn7hcm4tC/zpiDSOFvgHMw7rmGB4rXd01LVF2umpAWNmUXVI+A77NrXEsOL7HbvVuhyNYKQnQQE/thkFrA46ONq79L4CLu/J8AeN0rc/VT42pBnq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqzO/5Iq+apwmVEFrzg3LOY5k/M8vmc/ibvsOAn7KxmRiEmQdWB8Svfd0jNimRWbC/WvzclMOMEz2YmqOfJPz0SB0N6PZLkxfmpmAQX6S10nqZVoF/z/2LsPBiZXyWATZ9yIl9OXXiWw6FbXMBOD6xArbvUwVjwf7jNXr9Tit8Ze/1YOAJGWDNv8XOPQZAVVw1TFUPbx3SClHnc3QuXYRCRSe/amU+VUKIs/JgJLr/sKjrhqYOTFLpejROLaItz0+1AqjMnXY2DkduHWmma1L5oLozUASPUAcF7l4yeXglMetgJ9xP8Q/bSa7pLe8mVcPyeylQjh260mg/oJIDANnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AUtDGoLsGZHyv5G0bemiO1GU2ct8CcbcrYKH0xe+dik=;
 b=KGZkZDLK6KbMTFt6hUxaa9NUdbE20Epfvfq+KavrIhOYNx444oEH8RdbAJgjTf2B+DkJa1FQW2O7WY/teRn7AEx473b8zQ+KYOSKRakaLfKco3u8m3VGcpmB0sJO3KQeVhOUypU8gjc+Wfg/sEdHqdepA0WJsomlYD2gXt3PhrB99bUVTUGW6V3Who18ZLghqDZT/uC+nsA/pE4JvP/YTsCT/m4/rCD9aNIsmZ6FbB+xkHgtRLh25z+D4YNeO6at7bhaiqSUlhyqItHZQsy/ijw4+A2/JgqEmDfCup2hVjI38EF6YV+EUFTw6B/tHdGrruSYXdEjBrk38/sb3gVlew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO7P123MB8442.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:45f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 19:58:43 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 19:58:43 +0000
Date: Wed, 5 Aug 2026 15:58:39 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	rishil1999@outlook.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] perf sched: Handle missing trace samples in pipe
 mode
Message-ID: <wzf27ij47dfkqsr4jem2qsjpj5pdqdd7jubabfkzuoxomxjnlg@pfxacyx7f3n3>
References: <20260802210914.199941-1-atomlin@atomlin.com>
 <20260802210914.199941-3-atomlin@atomlin.com>
 <anDW_LwPhXrtBrUm@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anDW_LwPhXrtBrUm@google.com>
X-ClientProxiedBy: IA4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO7P123MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0356d4-dbdc-485f-6b05-08def32bf373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6B13cFQtzvr/uFzxKs3jZ+6PBjQ2duZ88kWgLHvjUj/qZ1eVpjIxHM7vaSTnEKTodtW23KIkQHVTE8tg0+vHxnkZ+sSI8sNJoJnzQqbVWgus+Kku1HBz+J2mRU9ULPjrwJETkJOuKXpYKGosD48E14mLFEVui/6gc47t3fRIdpxhEClN+zaljfD73FqDebm+dRy4yS3sWkrl8NNPoAXmDatb4fZi2oWw15bzccJvadz+BzAP6eS5Yoz09/K/kopgiYw5jfM3bLiFr6TdBDjLz8rfzAILrtjpGdj3TQLgmJyjPaH6V/qr9aV/+pXSXIgIor40vsi8PU0zh+ZVSnRcMkLVaCb0D7TEx3jD2pQbDx1TxhAuT/vCf0mBsYMWzv0ZunVQZ3J6lJz41SbPNKuAShfFqvxSUo3Z/oZVS1KdKHRjEEzVsHee6mUacuAXdreLJZ8tTltSuzVxUS9ciS7l4eoPv66y9NDuH+ICwmhy4/QxQ2h5bs4JMikw1UL5F/UnW+EUmv8Tj5L/ACpDMDrEpo/VwoyPZV3GVbJ1NefQIyQABIfIZIoZ3CV+qr43dS+hcPGIXV6AO+cJDgITD9IjNy4jt+pZNHqjBgp0G/Qls9UOhiB06npg5HCA02RaDK0fAW76JCpca9p8urakdcSb6jZVu+xqJqM7RTqVEelivHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHF6eWFEOFYxam0vSVh6eWFpVVZWQ3B6SVpPZmRtV3V5by9pZHg3QWF1Zzcv?=
 =?utf-8?B?ZUk4WnFrV2FybTZ0Y3dzQ2RuRVVOcWhucU5FLzlSb1VnWmdKcWJQbW9TWXlH?=
 =?utf-8?B?TUd6SVNwbHJrVENtNk4wQ3F0R1p2enlLQmp5Vi9yaS8rbmRxUmZsTHpUZW16?=
 =?utf-8?B?eVhGb3M2VnlOdnlyQktUYUI4ZmZpWXk4VWwvTHZGNFR6aUV0a2RkSW01N0p3?=
 =?utf-8?B?NXp2ZFVydVVqZFVLNEtmdHZnSll3N2dmZVpHMHc2VkRrZThEUkFqcTUzeHpV?=
 =?utf-8?B?eHE3Y1oyemdWSGZHazFJeWNZcTVyZ2xWSE1rT2VuNVlWQU1ZeEtVcXdnYmpH?=
 =?utf-8?B?MnFMVk9vWE9GTE9jcGF2SlZPTkUzSXdraWh3cVhSZmppOWNRWHlsdEx3NTM5?=
 =?utf-8?B?NzVweHR1WTZhMmsybFBBREhLSGg1c21KZ1BCLzV6Nys5NndQc2dLNUF2dUhC?=
 =?utf-8?B?Tml4dGV4SVdmM3l3L0hnWFlnZFpVSXFtVG43QTNMbXhCVkpWdm10MmsvUTB5?=
 =?utf-8?B?UFQ3aFBCb0MzdUpwWUJBSVdBNE1FamtobFhkakpSMXFDSW1QZjdOZHlyUngw?=
 =?utf-8?B?VWxqWUlQSm1yN280QzhrZGFNbkpURk8vU2cyelR3U3ZJY0tkR0FGOEdESlNr?=
 =?utf-8?B?MVFpOEZVdHF0UlQ0bndrc3cyU3FxeTI0SHJCSVRRL2NXdDZ2L0lpajNtVnNo?=
 =?utf-8?B?VXpjdkJTcENLaHBkVklScXk0dXFEVUtrNzZyQzlvZjMyWG9HMWEvRk82QXNO?=
 =?utf-8?B?MFNIRTdNMlVQSWZYYXVFZjUvKzRNZXFQcEhkTHRFenRFVjNJbm5XYU9mNjlC?=
 =?utf-8?B?MnVWcTBYLzJYZStsTFNkWVhUUWdUVkdZNzdjcUk2VVJBVmsyQXZPUUprM21Q?=
 =?utf-8?B?aGdYZUFjY1BrM3pmb253K0dMb25FemhBc1luSVZEWmRjMVFWc3k2QXY5S0lJ?=
 =?utf-8?B?dnNUTzdaQk5Ed2tDVnQyRkVYOTQ1ZUlwT2ZiTW0vejhIamVUU1NTTFBibytq?=
 =?utf-8?B?MGgxL0xpRzZrTS9FN0s0TFdjT3Yrc2MyKy9tSkpRVjlwM1ZkY0tWNlliT0RI?=
 =?utf-8?B?TlJjYTZ0QXl6YzRkd0NZYkNzL3JiL1VVaWZiU2Vob2lGUE1qV0gzSGpTNTBH?=
 =?utf-8?B?ZWg4SFJUVWo3WFFjK1A2THd6aHhpSlZBVGxaeGRJTitaVysvNE5LRlc5M3NJ?=
 =?utf-8?B?SkptQm9POHF6eE92UkZUVHZCQzFJMGpjZ3FvYVlPK0ZYSEZvWjJBNzZaa0lX?=
 =?utf-8?B?N0h4aXh3dTA3cllKZTJwN0ZPOFJ2NkUyaHp3OTJManI5Mk16QzA1UU1ZdThN?=
 =?utf-8?B?dDFGQ2hDSGxLQkRPVmZ3cFRNV1FYY2tBL3RBdmhKWC85UXZSUEVlQlJXWFF5?=
 =?utf-8?B?a2RHZTRLeWhPRm9rbW4raUVsaTJWTzdma1hTVy9ZdmkwVjhtTW45czZ2aGJ0?=
 =?utf-8?B?Z1JMQms5aHFzVTNMbEszR25GeEF4UXl1dWo1ZzhXMEkwMjV1V3YrQmFKUUpa?=
 =?utf-8?B?cHlPek54MittZG4wemxLdmtGQ1htRjNCR1N1RlZubG94eXhBNjczRWNacnRZ?=
 =?utf-8?B?VmtPV2VYam50enVXVkNvY28yWG45MGxCL2dQb3NEN2lRYXBGTk4xdTdKUDVj?=
 =?utf-8?B?Y3Bpdlg3QWx4QTI3OTYvZlJvbmRkR2l0a0kvRndEUTBIMTd0c1NpcmY4RTdC?=
 =?utf-8?B?UzJTTElBNFZXcUxzL2xDMjUzQmlSQTVxQTdYNjBMWVhUb3g3dnFKM29aU3Fk?=
 =?utf-8?B?ZUdoWVdWTWh2OFQrOGlxVzdxTG5VSkorOEJkeWsvemJYV2tsK3BtcTdBTUVI?=
 =?utf-8?B?NVJlM1JDMzZlenBWMktUaVZoMG1zSjRzQXl1c3lCRnNFdklxa1ZaaTZFOGZH?=
 =?utf-8?B?VXdYcVF5eFYzYmh1NmZwOFVDZlk2eUIzUEFMVitnZWNKOG5NR3hCM2k2NmMr?=
 =?utf-8?B?QWtPb04rNWNuQ2lsc0NsQmpsNGtLUUNyUVVDbDE5Y2dEZUtYMmIyc0d0Z054?=
 =?utf-8?B?a2pSQ3JrbHF6TlVIaTFweWRBcGJqTWllLy9TWnd6eXYzb2tjZFJZaTB6emV2?=
 =?utf-8?B?N0xvcjNxbkRUL2lzQTFLT04xSm1yNklqYnp6TThiUkUrMDdMUm9YdFRTS0N5?=
 =?utf-8?B?VHhYZCttVDBtSVpaNmZRNDZsaVA5bXA5QlJhT0pkdWdWOFdCKzFKWEFwMk5y?=
 =?utf-8?B?L3g2aDBnZjlTVG9NTHlUVzZLb3F5STZyT3NOZjdKQldqNW1nSEY5cGtVSldq?=
 =?utf-8?B?U2V0TTVsYVhRZ3QzOVZONFJyc25KWHhlMlhOUmpDUjdhU3Q5NzZEVkxsZFJi?=
 =?utf-8?B?bDVrdDJNWDErZVJ3RHh5cGkyR3ZhZTI0RzNUTUxaS2dFeVFza2dOUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0356d4-dbdc-485f-6b05-08def32bf373
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 19:58:42.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1fTq43OZoW+DQRbNOgH4y/nUvTFjXFxYO9g7YA3KphXA02JiDbN6bn9XPcSJS7jJRHz8oOK27h8QoLaBtwRdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB8442

On Mon, Aug 03, 2026 at 10:59:24AM -0700, Namhyung Kim wrote:
> On Sun, Aug 02, 2026 at 05:09:12PM -0400, Aaron Tomlin wrote:
> > For pipe mode streams, event attributes are received dynamically during
> > event processing, meaning session->evlist is not populated prior to
> > perf_session__process_events(). To handle pipe input correctly:
> >   - Register the missing .attr, .tracing_data, .build_id, and .feature
> >     callbacks in cmd_sched()
> > 
> >   - Promote the handlers array to file-scope (latency_handlers[]) and
> >     dynamically assign matching tracepoint handlers (or a dummy ignore
> >     handler) inside perf_sched__process_tracepoint_sample() when
> >     evsel->handler is NULL
> > 
> >   - Perform the trace check post-processing when handling pipe data
> > 
> > Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  tools/perf/builtin-sched.c | 65 +++++++++++++++++++++++++++++---------
> >  1 file changed, 50 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 94a323da0799..232e72537df3 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -1938,6 +1938,22 @@ typedef int (*tracepoint_handler)(const struct perf_tool *tool,
> >  				  struct perf_sample *sample,
> >  				  struct machine *machine);
> >  
> > +static struct evsel_str_handler latency_handlers[] = {
> > +	{ "sched:sched_switch",       process_sched_switch_event, },
> > +	{ "sched:sched_stat_runtime", process_sched_runtime_event, },
> > +	{ "sched:sched_wakeup",       process_sched_wakeup_event, },
> > +	{ "sched:sched_waking",       process_sched_wakeup_event, },
> > +	{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
> > +	{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
> > +};
> > +
> > +static int process_sched_ignore(const struct perf_tool *tool __maybe_unused,
> > +				struct perf_sample *sample __maybe_unused,
> > +				struct machine *machine __maybe_unused)
> > +{
> > +	return 0;
> > +}
> > +
> >  static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
> >  						 union perf_event *event __maybe_unused,
> >  						 struct perf_sample *sample,
> > @@ -1946,7 +1962,22 @@ static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __
> >  	struct evsel *evsel = sample->evsel;
> >  	int err = 0;
> >  
> > -	if (evsel->handler != NULL) {
> > +	if (evsel->handler == NULL) {
> > +		evsel->handler = process_sched_ignore;
> > +		for (size_t i = 0; i < ARRAY_SIZE(latency_handlers); i++) {
> > +			if (evsel__name_is(evsel, latency_handlers[i].name)) {
> 
> Please consider using 'continue' statement for the opposite case to
> reduce the indent level.

Acknowledged.

> > +				if (!strcmp(latency_handlers[i].name, "sched:sched_wakeup") &&
> > +				    sample->evsel->evlist &&
> > +				    evlist__find_tracepoint_by_name(sample->evsel->evlist, "sched:sched_waking"))
> > +					evsel->handler = process_sched_wakeup_ignore;
> 
> Probably better to use/keep the process_sched_ignore().
> 
> I think we could replace others to use the function and get rid of the
> dummy wakeup_ignore functions.  But it could be a separate change.

I can resolve this now—it'll be cleaner.


Kind regards,
-- 
Aaron Tomlin
