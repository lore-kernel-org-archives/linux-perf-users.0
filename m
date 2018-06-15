From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 2/3] perf alias: Rebuild alias expression string to make
 it comparable
Date: Fri, 15 Jun 2018 11:09:05 +0200
Message-ID: <f78bbadb-047d-afad-eac6-b1236bd56c81@linux.ibm.com>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-2-tmricht@linux.ibm.com>
 <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
 <20180615081242.GF5082@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615081242.GF5082@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, Paul Clarke <pc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On 06/15/2018 10:12 AM, Jiri Olsa wrote:
> On Thu, Jun 14, 2018 at 08:53:14AM -0500, Paul Clarke wrote:
> 
> SNIP
> 
>>> +		if (ret)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 ",");
>>> +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 "%s=%#x", term->config, term->val.num);
>>> +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
>>> +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
>>> +					 "%s=%s", term->config, term->val.str);
>>
>> If we exceed 256, we just suddenly terminate the rebuilding without reporting any issues.
>>
>>> +	}
>>> +
>>>  	alias->name = strdup(name);
>>>  	if (dir) {
>>>  		/*
>>> @@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>>>  	}
>>>  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>>> -	alias->str = strdup(val);
>>> +	alias->str = strdup(newval);
> 
> hum, how is newval different from val? AFAICS it's the same
> 

Not really, depends on the platform, here is some debug output from s390:
root@s35lp76 perf]# ./perf stat -e tx_nc_tend -- ~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_nc_tend                                                  

       0.001050150 seconds time elapsed

[root@s35lp76 perf]# fgrep -i tx_nc_tend /tmp/111
__perf_pmu__new_alias TX_NC_TEND val:event=0x008d newval:event=0x8d
__perf_pmu__new_alias tx_nc_tend val:event=0x8d newval:event=0x8d
TX_NC_TEND	1 rc 8
[root@s35lp76 perf]# 

On s390 the events in the PMU sysfs file are printed with leading zeroes.
This means the strcmp() of alias->str differs, but the contents is logically
identical. (Same of some files contains spaces).

Thats why I do the rewrite of val into newval.

The alias name does not match too, but we use strcasecmp() to ignore case.

Hope this helps.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
