From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 7/7] perf script python: add printdate function to SQL
 exporters
Date: Fri, 8 Mar 2019 14:50:11 +0200
Message-ID: <193287e8-0710-4d27-dd5c-939fff451a15@intel.com>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-8-tonyj@suse.de> <20190306211359.GR30734@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306211359.GR30734@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 6/03/19 11:13 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 01, 2019 at 05:19:03PM -0800, Tony Jones escreveu:
>> Introduce a printdate function to eliminate the repetitive use of
>> datetime.datetime.today() in the SQL exporting scripts.
> 
> Seems easy enough, but since Adrian provided the Acked-by to the other
> patch, can this be done this time again?

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
