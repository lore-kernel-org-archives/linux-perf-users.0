From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: ftrace function filter
Date: Fri, 4 Mar 2011 13:26:32 +0100
Message-ID: <AANLkTimLhbiG1=8CAybRA+emT6WW44BKcR9JQRGbRRNt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63466 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab1CDM0d (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Mar 2011 07:26:33 -0500
Received: by gyh20 with SMTP id 20so784113gyh.19
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Mar 2011 04:26:32 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I would like to trace some function of the cpu hotplug feature on an
Arm platform with ftrace in order to get the time spent in the
different steps. I have tried to use the function/function_graph
tracer with set_ftrace_filter but some function like _cpu_down are not
in the available_filter_functions list. Is it possible to have
_cpu_down in the list ? Do I need to enable some kernel configuration
? I have added part of my config below

CONFIG_TRACEPOINTS=y
CONFIG_STACKTRACE=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_GENERIC_TRACER=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set

Thanks,
Vincent
