From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH 02/15] perf script python: add Python3 support to
 check-perf-trace.py
Date: Mon, 25 Feb 2019 10:05:47 -0800
Message-ID: <82af3618-8d99-7985-aa3c-3bdc6231d4cf@suse.de>
References: <20190222230619.17887-1-tonyj@suse.de>
 <20190222230619.17887-3-tonyj@suse.de> <20190225140535.GE31136@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190225140535.GE31136@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, Tom Zanussi <tzanussi@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

On 2/25/19 6:05 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 22, 2019 at 03:06:06PM -0800, Tony Jones escreveu:
>> Support both Python 2 and Python 3 in the check-perf-trace.py script.
>>
>> There may be differences in the ordering of output lines due to
>> differences in dictionary ordering etc.  However the format within lines
>> should be unchanged.
>>
>> Also correct inconsistent indentation which was being flagged by Python3.
> 
> When we have "Also" in a patch, usually it need to be split :-)

The indentation changes were required for Python3. So I viewed them as part of the change
to support Python3 ;-)  However, splitting them is no problem.    I'll resubmit.
